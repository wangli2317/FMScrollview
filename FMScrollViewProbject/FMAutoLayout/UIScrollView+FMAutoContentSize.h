//
//  UIScrollView+FMAutoContentSize.h
//  GSD_WeiXin(wechat)
//
//  Created by 王刚 on 6/4/16.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (FMAutoContentSize)
/** 设置scrollview内容竖向自适应 */
- (void)setupAutoContentSizeWithBottomView:(UIView *)bottomView bottomMargin:(CGFloat)bottomMargin;

/** 设置scrollview内容横向自适应 */
- (void)setupAutoContentSizeWithRightView:(UIView *)rightView rightMargin:(CGFloat)rightMargin;
@end
