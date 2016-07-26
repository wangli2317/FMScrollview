//
//  FMImgPickerViewController.h
//  mogi
//
//  Created by 王刚 on 3/5/16.
//  Copyright © 2016年 com.8w4q. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FMImgPickerViewControllerDelegate <NSObject>

@optional
- (void)FMImagePickerDidFinishWithImages:(NSArray *)imageArray;

@end

@interface FMImgPickerViewController : UIViewController

@property(nonatomic,assign)BOOL hiddenChoosenImage;

- (void)showInViewContrller:(UIViewController *)vc choosenNum:(NSInteger)choosenNum maxChooseCount:(NSInteger)maxChooseCount delegate:(id<FMImgPickerViewControllerDelegate>)vcdelegate;

@end
