//
//  FMTestScrollViewController.m
//  mogi
//
//  Created by cherry on 15/12/17.
//  Copyright © 2015年 com.8w4q. All rights reserved.
//

#import "FMTestScrollViewController.h"
#import "FMScrollViewManager.h"
#import "FMTestFooterScrollViewCell.h"
#import "FMImgPickerViewController.h"
#import "FMConfigure.h"

#import "FMTestScrollViewCell.h"
#import "FMTestExpandScrollViewCell.h"

#import "FMTestFooterDTO.h"
#import "FMTestHeaderDTO.h"
#import "FMTestScrollViewDTO.h"
#import "FMTestExpandDTO.h"

@interface FMTestScrollViewController () <FMScrollViewManagerDelegate,FMImgPickerViewControllerDelegate>

@property (nonatomic, strong) FMScrollViewManager *scrollViewManager;

@end

@implementation FMTestScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:235/255.0 blue:237/255.0 alpha:1];
    
    self.scrollViewManager = [[FMScrollViewManager alloc] initWithDataMethod:@"fetchTestDataByPage:otherParams:success:failed:" frame:self.view.frame andDelegate:self defaultClassType:@"FMTestScrollViewCell" columnWidth:5.0f startY:20.0f leftMarginCols:2 cellPaddingTop:5 otherParams:nil needPzRefreshControl:YES];
    
    FMTestFooterDTO *DTO = [FMTestFooterDTO new];
    DTO.name = @"八万四千";
    DTO.FM_CLASSTYPE = @"FMTestFooterScrollViewCell";
    DTO.title = @"Copyright © 2009-2016 oNightJar.com. All screenshots © their respective owners. Handcrafted in Beijing.";
    
    [self.scrollViewManager startLoadWithFooterItems:@[DTO]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) addHeader{
    
    FMTestHeaderDTO *headerDTO = [FMTestHeaderDTO new];
    headerDTO.FM_CLASSTYPE = @"FMTestHeaderScrollViewCell";
    headerDTO.content = @"This is a header!!";
    
    [self.scrollViewManager.scrollView append:[[NSMutableArray alloc] initWithObjects:headerDTO, nil]];
}

- (void) beforeAddScrollView{
    [self addHeader];
}
- (void) afterAddScrollView{
    
}
- (void) afterReloadScrollView{
    [self addHeader];
    
}
- (UIView*) getParentView{
    return self.view;
}

- (void) buttonClicked:(id)sender cell:(FMScrollViewCell *) cell{
    
    UIButton *button = sender;
    if (button.tag == FMExpandButtonTypeDelete) {
        [self.scrollViewManager deleteDataAtIndex:cell.index];
    }else{
        if([self.scrollViewManager.scrollView isExpandedAtIndex:cell.index]){

            [cell resizeFrameWithExpandWidth:0 expandHeight:0];

        }else{

            [cell resizeFrameWithExpandWidth:0 expandHeight:100];

        }
    }

}

-(void)cellClicked:(FMScrollViewCell *)cell{
    if ([cell isKindOfClass:[FMTestFooterScrollViewCell class]]) {
                
        __weak __typeof(self)wself = self;
        FMImgPickerViewController *vc =[[FMImgPickerViewController alloc]init];
        vc.view.backgroundColor = UIColorFromRGB(0xeeeeee);
        vc.hiddenChoosenImage = NO;
        [vc showInViewContrller:wself choosenNum:0 maxChooseCount:6 delegate:wself];
    }else if ([cell isKindOfClass:[FMTestScrollViewCell class]]){
        
        FMTestScrollViewDTO *DTO = cell.object;
        NSLog(@"%@",DTO.content);
    }else if ([cell isKindOfClass:[FMTestExpandScrollViewCell class]]){

        FMTestExpandDTO *DTO = cell.object;
        NSLog(@"%@",DTO.content);
    }
}

- (void)FMImagePickerDidFinishWithImages:(NSArray *)imageArray{
    NSLog(@"%td",imageArray.count);
}

@end
