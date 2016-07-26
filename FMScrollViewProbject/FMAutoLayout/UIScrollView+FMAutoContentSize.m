//
//  UIScrollView+FMAutoContentSize.m
//  GSD_WeiXin(wechat)
//
//  Created by 王刚 on 6/4/16.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "UIScrollView+FMAutoContentSize.h"
#import "UIView+FMAutoHeightWidth.h"

@implementation UIScrollView (FMAutoContentSize)
- (void)setupAutoContentSizeWithBottomView:(UIView *)bottomView bottomMargin:(CGFloat)bottomMargin{
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:bottomMargin];
}

- (void)setupAutoContentSizeWithRightView:(UIView *)rightView rightMargin:(CGFloat)rightMargin{
    if (!rightView) return;
    
    self.fm_rightViewsArray = @[rightView];
    self.fm_rightViewRightMargin = rightMargin;
}
@end
