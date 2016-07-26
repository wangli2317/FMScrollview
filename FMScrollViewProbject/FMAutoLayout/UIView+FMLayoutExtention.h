//
//  UIView+FMLayoutExtention.h
//  Gfm_WeiXin(wechat)
//
//  Created by 王刚 on 6/4/16.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FMLayoutExtention)
/** 自动布局完成后的回调block，可以在这里获取到view的真实frame  */
@property (nonatomic) void (^didFinishAutoLayoutBlock)(CGRect frame);

/** 添加一组子view  */
- (void)fm_addSubviews:(NSArray *)subviews;

/* 设置圆角 */

/** 设置圆角半径值  */
@property (nonatomic, strong) NSNumber *fm_cornerRadius;
/** 设置圆角半径值为view宽度的多少倍  */
@property (nonatomic, strong) NSNumber *fm_cornerRadiusFromWidthRatio;
/** 设置圆角半径值为view高度的多少倍  */
@property (nonatomic, strong) NSNumber *fm_cornerRadiusFromHeightRatio;

/** 设置等宽子view（子view需要在同一水平方向） */
@property (nonatomic, strong) NSArray *fm_equalWidthSubviews;
@end
