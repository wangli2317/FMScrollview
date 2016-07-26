//
//  UIView+FMLayoutExtention.m
//  Gfm_WeiXin(wechat)
//
//  Created by 王刚 on 6/4/16.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "UIView+FMLayoutExtention.h"
#import <objc/runtime.h>

@implementation UIView (FMLayoutExtention)
- (void (^)(CGRect))didFinishAutoLayoutBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDidFinishAutoLayoutBlock:(void (^)(CGRect))didFinishAutoLayoutBlock{
    objc_setAssociatedObject(self, @selector(didFinishAutoLayoutBlock), didFinishAutoLayoutBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)fm_cornerRadius{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFm_cornerRadius:(NSNumber *)fm_cornerRadius{
    objc_setAssociatedObject(self, @selector(fm_cornerRadius), fm_cornerRadius, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSNumber *)fm_cornerRadiusFromWidthRatio{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFm_cornerRadiusFromWidthRatio:(NSNumber *)fm_cornerRadiusFromWidthRatio{
    objc_setAssociatedObject(self, @selector(fm_cornerRadiusFromWidthRatio), fm_cornerRadiusFromWidthRatio, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSNumber *)fm_cornerRadiusFromHeightRatio{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFm_cornerRadiusFromHeightRatio:(NSNumber *)fm_cornerRadiusFromHeightRatio{
    objc_setAssociatedObject(self, @selector(fm_cornerRadiusFromHeightRatio), fm_cornerRadiusFromHeightRatio, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)fm_equalWidthSubviews{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFm_equalWidthSubviews:(NSArray *)fm_equalWidthSubviews{
    objc_setAssociatedObject(self, @selector(fm_equalWidthSubviews), fm_equalWidthSubviews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)fm_addSubviews:(NSArray *)subviews{
    [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if ([view isKindOfClass:[UIView class]]) {
            [self addSubview:view];
        }
    }];
}

@end
