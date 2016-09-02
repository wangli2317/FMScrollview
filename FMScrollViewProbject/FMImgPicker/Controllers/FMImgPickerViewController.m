//
//  FMImgPickerViewController.m
//  mogi
//
//  Created by 王刚 on 9/5/16.
//  Copyright © 2016年 王刚. All rights reserved.
//

#import "FMImgPickerViewController.h"
#import "FMConfigure.h"
#import "FMScrollViewManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "FMImgPickerTableViewCell.h"
#import "UIView+extension.h"
#import "FMImgPickerDTO.h"
#import "FMImgPickerHeaderViewCell.h"
#import "FMImgPickerTableDTO.h"
#import "FMImgPickerTitleButtonView.h"

#define tableH MIN(CGRectGetWidth([UIScreen mainScreen].bounds) - 64, tableCellH * self.tableData.count)


@interface FMImgPickerViewController ()<FMScrollViewManagerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,FMImgPickerTitleButtonViewDelegate>

@property (nonatomic , weak   ) id <FMImgPickerViewControllerDelegate> delegate;
@property (nonatomic , strong ) FMScrollViewManager               *  scrollViewManager;
@property (nonatomic , strong ) UINavigationController            *  nav;
@property (nonatomic , weak   ) UIView                            *  footerView;
@property (nonatomic , strong ) UITableView                       *  myTableView;
@property (nonatomic , strong ) ALAssetsLibrary                   *  assetsLibrary;
@property (nonatomic , strong ) ALAssetsGroup                     *  group;
@property (nonatomic , strong ) NSMutableArray                    *  tableData;
@property (nonatomic , strong ) NSMutableDictionary               *  choosenImgArray;
@property (nonatomic , strong ) NSMutableDictionary               *  isChoosenDic;
@property (nonatomic , weak   ) UIButton                          *  progressButton;
@property (nonatomic , assign ) BOOL                              isShowTable;
@property (nonatomic , assign ) NSInteger                         choosenCount;
@property (nonatomic , assign ) NSInteger                         maxChooseCount;
@property (nonatomic , weak   ) FMImgPickerTitleButtonView        *  titleBtn;
@end

@implementation FMImgPickerViewController

static NSString * const tableReuseIdentifier = @"tableCell";
static NSInteger const tableCellH = 70;

-(void)dealloc{
    self.tableData = nil;
    self.choosenImgArray = nil;
    self.isChoosenDic = nil;
    self.myTableView = nil;
    self.titleBtn = nil;
    self.delegate = nil;
    self.assetsLibrary = nil;
    self.group = nil;
}


-(instancetype)init{
    self = [super init];
    if (self) {
        _myTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _nav = [[UINavigationController alloc] initWithRootViewController:self];
        _assetsLibrary = [[ALAssetsLibrary alloc]init];
        _tableData = [[NSMutableArray alloc]init];
        _choosenImgArray = [[NSMutableDictionary alloc]init];
        _isChoosenDic = [[NSMutableDictionary alloc]init];
        _choosenCount = 0;
        [self initDefaultView];
        [self getTableDate];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0xffffff);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollViewManager = [[FMScrollViewManager alloc]initWithDataMethod:nil frame:self.view.bounds andDelegate:self defaultClassType:@"FMImgPickerViewCell" columnWidth:1 startY:5 leftMarginCols:3 cellPaddingTop:3 otherParams:nil needPzRefreshControl:NO];
    
    [self.scrollViewManager startLoad];
    
    [self.view addSubview:self.myTableView];
    
}

- (void) initDefaultView{
    //naviegationBar
    self.navigationItem.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xffffff)];
    
    FMImgPickerTitleButtonView *titleBtn = [[FMImgPickerTitleButtonView alloc]initWithFrame:self.navigationItem.titleView.frame];
    titleBtn.titleString = @"相册胶卷";
    [self.navigationItem.titleView addSubview:titleBtn];
    self.titleBtn = titleBtn;
    titleBtn.delegate = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"editor_close"] style:UIBarButtonItemStyleDone target:self action:@selector(hide)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blackColor]];
    
    //tableView
    self.myTableView.rowHeight = tableCellH;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.hidden = YES;
    
    self.isShowTable = NO;
    CGFloat footViewHeight = 44;
    CGSize mainScreenSize =  [UIScreen mainScreen].bounds.size;
    CGFloat accomplishButtonMargin = 30;
    CGFloat progressButtonMargin = 12;
    //添加底部footView
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0,mainScreenSize.height - footViewHeight, mainScreenSize.width, footViewHeight)];
    footView.backgroundColor = [UIColor whiteColor];
    self.footerView = footView;
    
    //添加完成
    UIButton *accomplishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [accomplishButton setTitle:@"完成" forState:UIControlStateNormal];
    [accomplishButton setTitleColor:UIColorFromRGB(0xcc7130) forState:UIControlStateNormal];
    accomplishButton.titleLabel.font = LIGHTMEDIUM_FONT(16);
    [accomplishButton sizeToFit];
    CGSize accomplishButtonSize = accomplishButton.frame.size;
    accomplishButton.frame = CGRectMake(mainScreenSize.width - accomplishButtonSize.width - accomplishButtonMargin, (footViewHeight - accomplishButtonSize.height) * 0.5, accomplishButtonSize.width, accomplishButtonSize.height);
    [footView addSubview:accomplishButton];
    [accomplishButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *progressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [progressButton setTitle:[NSString stringWithFormat:@"%ld/%td",(long)self.choosenCount,self.maxChooseCount] forState:UIControlStateNormal];
    [progressButton setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [progressButton setBackgroundImage:[UIImage imageNamed:@"editor_sendbtn"] forState:UIControlStateNormal];
    progressButton.titleLabel.font = LIGHTMEDIUM_FONT(16);
    progressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [footView addSubview:progressButton];
    progressButton.userInteractionEnabled = NO;
    progressButton.fm_layout.leftSpaceToView(footView,progressButtonMargin).rightSpaceToView(accomplishButton,progressButtonMargin).heightIs(footViewHeight);
    self.progressButton = progressButton;
    
    [self.view addSubview:self.footerView];
}

- (void)getTableDate {
    __weak __typeof(self)wself = self;
    void (^assetsGroupsEnumerationBlock)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *assetsGroup, BOOL *stop) {
        __strong __typeof(wself)strongSelf = wself;
        
        if(assetsGroup) {
            
            [assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
            [strongSelf.tableData addObject:assetsGroup];
            
            NSMutableArray * isChoosenArray = [[NSMutableArray alloc]init];
            
            if(assetsGroup.numberOfAssets > 0) {
                for (int i = 0; i<assetsGroup.numberOfAssets; i++) {
                    [isChoosenArray addObject:[NSNumber numberWithBool:NO]];
                }
                
                [isChoosenArray insertObject:[NSNumber numberWithBool:NO] atIndex:0];
                [strongSelf.isChoosenDic setObject:isChoosenArray forKey:[assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
                
            }
            [strongSelf setTableViewHeight];
        }
        [strongSelf.myTableView reloadData];
        if ([assetsGroup valueForProperty:ALAssetsGroupPropertyPersistentID] == nil ) {
            [strongSelf getCollectionData:0];
        }
    };
    
    void (^assetsGroupsFailureBlock)(NSError *) = ^(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    };
    
    // Enumerate Camera Roll
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
}



- (void)setTableViewHeight {
    self.myTableView.height = tableH;
    self.myTableView.y = -tableH;
}

- (void)getCollectionData:(NSInteger)tag {
    
    NSMutableDictionary *otherParams = [NSMutableDictionary dictionary];
    
    if (self.tableData.count) {
        self.group = [self.tableData objectAtIndex:tag];
        
        self.titleBtn.titleString = [self.group valueForProperty:ALAssetsGroupPropertyName];
        
        [otherParams setValue:self.group forKey:@"group"];
        [otherParams setValue:@(self.hiddenChoosenImage) forKey:@"hiddenChoosenImage"];
        [self.scrollViewManager changeDataSourceWithDataMethod:@"fetchImgPickerDataByPage:otherParams:success:failed:" otherParams:otherParams];
    }
}

- (void)showTableView {
    if (self.tableData!=nil&&self.tableData.count>0) {
        __weak __typeof(self)wself = self;
        wself.myTableView.hidden = NO;
        if (wself.isShowTable) {
            [UIView animateWithDuration:0.45 animations:^{
                
                wself.myTableView.y += 5;
                [wself.view layoutIfNeeded];
                
            } completion:^(BOOL finished) {
                wself.titleBtn.imageView.transform = CGAffineTransformMakeRotation(0);
                [UIView animateWithDuration:0.35 animations:^{
                    
                    wself.myTableView.y = -tableH;
                    [wself.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                    wself.isShowTable = !wself.isShowTable;
                }];
            }];
        }else {
            [UIView animateWithDuration:0.45 animations:^{
                
                wself.myTableView.y = 64 +5;
                [wself.view layoutIfNeeded];
                
            } completion:^(BOOL finished) {
                wself.titleBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
                [UIView animateWithDuration:0.35 animations:^{
                    
                    wself.myTableView.y = 64;
                    [wself.view layoutIfNeeded];
                    
                } completion:^(BOOL finished) {
                    wself.isShowTable = !wself.isShowTable;
                }];
            }];
        }
    }
}



#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMImgPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier];
    if (!cell) {
        cell = [[FMImgPickerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableReuseIdentifier];
    }
    
    ALAssetsGroup * assetsGroup = [self.tableData objectAtIndex:indexPath.row];
    FMImgPickerTableDTO *imgPickerTableDTO = [FMImgPickerTableDTO new];
    
    imgPickerTableDTO.titleString = [NSString stringWithFormat:@"%@", [assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
    imgPickerTableDTO.numString = [NSString stringWithFormat:@"%td", assetsGroup.numberOfAssets];
    imgPickerTableDTO.albumImage = [UIImage imageWithCGImage:assetsGroup.posterImage];
    
    cell.imgPickerTableDTO = imgPickerTableDTO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self getCollectionData:indexPath.row];
    [self showTableView];
}

#pragma mark self
- (void)showInViewContrller:(UIViewController *)vc choosenNum:(NSInteger)choosenNum maxChooseCount:(NSInteger)maxChooseCount delegate:(id<FMImgPickerViewControllerDelegate>)vcdelegate{
    
    
    self.delegate = vcdelegate;
    self.choosenCount = choosenNum;
    self.maxChooseCount = maxChooseCount;
    
    if (maxChooseCount == 1){
        [self.footerView removeFromSuperview];
    }
    [vc presentViewController:self.nav animated:YES completion:nil];
    
}

- (void)save {
    NSMutableArray * resuletData = [NSMutableArray arrayWithArray:[self.choosenImgArray allValues]];
    for (int i = 0; i<resuletData.count; i++) {
        id result = [resuletData objectAtIndex:i];
        if ([result isKindOfClass:[FMImgPickerDTO class]]) {
            FMImgPickerDTO * pickerDTO = result;
            if ([pickerDTO.result isKindOfClass:[ALAsset class]]) {
                UIImage * image = [UIImage imageWithCGImage:[[pickerDTO.result defaultRepresentation] fullScreenImage]];
                [resuletData replaceObjectAtIndex:i withObject:image];
            }
        }else{
            UIImage *image = result;
            [resuletData replaceObjectAtIndex:i withObject:image];
        }
    }
    if ([self.delegate respondsToSelector:@selector(FMImagePickerDidFinishWithImages:)]) {
        [self.delegate FMImagePickerDidFinishWithImages:resuletData];
    }
    [self hide];
}

- (void)hide{
    [self dismissViewControllerAnimated:YES completion:^{
        self.nav = nil;
    }];
}


#pragma mark FMScrollViewManagerDelegate
- (void)cellClicked:(FMScrollViewCell *)cell{
    
    if ([cell isKindOfClass:[FMImgPickerHeaderViewCell class]]) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            imagePicker.showsCameraControls  = YES;
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:kCATransitionFromLeft ForView:[UIApplication sharedApplication].keyWindow];
            [self presentViewController:imagePicker animated:NO completion:nil];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有授权" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }else{
        
        NSMutableArray * isChoosenArray = [self.isChoosenDic objectForKey:[self.group valueForProperty:ALAssetsGroupPropertyName]];
        
        FMImgPickerDTO *pickerDTO = cell.object;
        
        if (!pickerDTO.isChoosen) {
            if (self.choosenCount > self.maxChooseCount) {
                return;
            }
            self.choosenCount += 1;
            [self.choosenImgArray setObject:pickerDTO forKey:@(cell.index)];
            
            if (self.choosenCount == self.maxChooseCount) {
                [self save];
            }
            
        }else {
            self.choosenCount -= 1;
            [self.choosenImgArray removeObjectForKey:@(cell.index)];
        }
        [self.progressButton setTitle:[NSString stringWithFormat:@"%ld/%ld",(long)self.choosenCount,(long)self.maxChooseCount] forState:UIControlStateNormal];
        [self.progressButton setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
        
        [isChoosenArray replaceObjectAtIndex:cell.index withObject:[NSNumber numberWithBool:!pickerDTO.isChoosen]];
        [self.isChoosenDic setObject:isChoosenArray forKey:[self.group valueForProperty:ALAssetsGroupPropertyName]];
        
        pickerDTO.isChoosen = !pickerDTO.isChoosen;
        [self.scrollViewManager.scrollView changeItemDataAtIndex:cell.index object:pickerDTO];
    }
}

- (void) beforeAddScrollView{
    [self addHeaderView];
}

- (void) afterAddScrollView{
    
}

- (void) afterReloadScrollView{
    [self addHeaderView];
}

- (UIView*) getParentView{
    return self.view;
}

- (void) addHeaderView{
    FMBaseDTO *baseDTO = [FMBaseDTO new];
    baseDTO.FM_CLASSTYPE = @"FMImgPickerHeaderViewCell";
    [self.scrollViewManager.scrollView append:[[NSMutableArray alloc] initWithObjects:baseDTO, nil]];
}

#pragma mark imagePickerTitleButtonDelegate
- (void)touchButtonView:(FMImgPickerTitleButtonView *)buttonView{
    [self showTableView];
}


#pragma mark imagePicker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage * image =[info objectForKey:UIImagePickerControllerOriginalImage];
    if (image) {
        
        // 保存图片到相册中
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera){
            UIImageWriteToSavedPhotosAlbum(image,self,nil, NULL);
            
            [self.choosenImgArray setObject:image forKey:@"camare"];
        }
        
        [picker dismissViewControllerAnimated:NO completion:^() {
            [self save];
        }];
        
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:kCATransitionFromLeft ForView:[UIApplication sharedApplication].keyWindow];
    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.7;
    
    //设置运动type
    animation.type = type;
    
    //设置子类
    animation.subtype = subtype;
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}


@end
