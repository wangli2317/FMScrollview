//
//  FMImgPickerTitleButtonView.h
//  mogi
//
//  Created by 王刚 on 9/5/16.
//  Copyright © 2016年 王刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMImgPickerTitleButtonView;

@protocol FMImgPickerTitleButtonViewDelegate <NSObject>
- (void)touchButtonView:(FMImgPickerTitleButtonView *)buttonView;
@end

@interface FMImgPickerTitleButtonView : UIView
@property (nonatomic,weak) UIImageView                        *imageView;
@property (nonatomic,copy) NSString                           *titleString;

@property (nonatomic,weak) id<FMImgPickerTitleButtonViewDelegate> delegate;
@end
