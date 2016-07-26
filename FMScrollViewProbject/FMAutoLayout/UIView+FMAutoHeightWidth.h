//
//  UIView+FMAutoHeightWidth.h
//  GSD_WeiXin(wechat)
//
//  Created by 王刚 on 6/4/16.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMUIViewCategoryManager;

@interface UIView (FMAutoHeightWidth)
/** 设置Cell的高度自适应，也可用于设置普通view内容高度自适应 */
- (void)setupAutoHeightWithBottomView:(UIView *)bottomView bottomMargin:(CGFloat)bottomMargin;

/** 用于设置普通view内容宽度自适应 */
- (void)setupAutoWidthWithRightView:(UIView *)rightView rightMargin:(CGFloat)rightMargin;

/** 设置Cell的高度自适应，也可用于设置普通view内容自适应（应用于当你不确定哪个view在自动布局之后会排布在最下方最为bottomView的时候可以调用次方法将所有可能在最下方的view都传过去） */
- (void)setupAutoHeightWithBottomViewsArray:(NSArray *)bottomViewsArray bottomMargin:(CGFloat)bottomMargin;

/** 更新布局（主动刷新布局，如果你需要设置完布局代码就获得view的frame请调用此方法） */
- (void)updateLayout;

/** 更新cell内部的控件的布局（cell内部控件专属的更新约束方法,如果启用了cell frame缓存则会自动清除缓存再更新约束） */
- (void)updateLayoutWithCellContentView:(UIView *)cellContentView;

/** 清空高度自适应设置  */
- (void)clearAutoHeigtSettings;

/** 清空宽度自适应设置  */
- (void)clearAutoWidthSettings;

@property (nonatomic) CGFloat autoHeight;

@property (nonatomic, readonly) FMUIViewCategoryManager *fm_categoryManager;

@property (nonatomic, readonly) NSMutableArray *fm_bottomViewsArray;
@property (nonatomic) CGFloat fm_bottomViewBottomMargin;

@property (nonatomic) NSArray *fm_rightViewsArray;
@property (nonatomic) CGFloat fm_rightViewRightMargin;


@end
