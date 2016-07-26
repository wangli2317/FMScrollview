//
//  UIView+FMAutoHeightWidth.m
//  Gfm_WeiXin(wechat)
//
//  Created by 王刚 on 6/4/16.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "UIView+FMAutoHeightWidth.h"
#import "FMUIViewCategoryManager.h"
#import <objc/runtime.h>
#import "UIView+FMAutoLayout.h"

@implementation UIView (FMAutoHeightWidth)

- (FMUIViewCategoryManager *)fm_categoryManager{
    FMUIViewCategoryManager *manager = objc_getAssociatedObject(self, _cmd);
    if (!manager) {
        objc_setAssociatedObject(self, _cmd, [FMUIViewCategoryManager new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setupAutoHeightWithBottomView:(UIView *)bottomView bottomMargin:(CGFloat)bottomMargin{
    if (!bottomView) return;
    
    [self setupAutoHeightWithBottomViewsArray:@[bottomView] bottomMargin:bottomMargin];
}

- (void)setupAutoWidthWithRightView:(UIView *)rightView rightMargin:(CGFloat)rightMargin{
    if (!rightView) return;
    
    self.fm_rightViewsArray = @[rightView];
    self.fm_rightViewRightMargin = rightMargin;
}

- (void)setupAutoHeightWithBottomViewsArray:(NSArray *)bottomViewsArray bottomMargin:(CGFloat)bottomMargin{
    if (!bottomViewsArray) return;
    // 清空之前的view
    [self.fm_bottomViewsArray removeAllObjects];
    [self.fm_bottomViewsArray addObjectsFromArray:bottomViewsArray];
    self.fm_bottomViewBottomMargin = bottomMargin;
}

- (void)clearAutoHeigtSettings{
    [self.fm_bottomViewsArray removeAllObjects];
}

- (void)clearAutoWidthSettings{
    self.fm_rightViewsArray = nil;
}

- (void)updateLayout{
    [self.superview layoutSubviews];
}

- (void)updateLayoutWithCellContentView:(UIView *)cellContentView{
    if (cellContentView.fm_indexPath) {
        [cellContentView fm_clearSubviewsAutoLayoutFrameCaches];
    }
    [self updateLayout];
}

- (CGFloat)autoHeight{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setAutoHeight:(CGFloat)autoHeight{
    objc_setAssociatedObject(self, @selector(autoHeight), @(autoHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)fm_bottomViewsArray{
    NSMutableArray *array = objc_getAssociatedObject(self, _cmd);
    if (!array) {
        objc_setAssociatedObject(self, _cmd, [NSMutableArray new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (NSArray *)fm_rightViewsArray{
    return [[self fm_categoryManager] rightViewsArray];
}

- (void)setFm_rightViewsArray:(NSArray *)fm_rightViewsArray{
    [[self fm_categoryManager] setRightViewsArray:fm_rightViewsArray];
}

- (CGFloat)fm_bottomViewBottomMargin{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setFm_bottomViewBottomMargin:(CGFloat)fm_bottomViewBottomMargin{
    objc_setAssociatedObject(self, @selector(fm_bottomViewBottomMargin), @(fm_bottomViewBottomMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setFm_rightViewRightMargin:(CGFloat)fm_rightViewRightMargin{
    [[self fm_categoryManager] setRightViewRightMargin:fm_rightViewRightMargin];
}

- (CGFloat)fm_rightViewRightMargin{
    return [[self fm_categoryManager] rightViewRightMargin];
}


@end
