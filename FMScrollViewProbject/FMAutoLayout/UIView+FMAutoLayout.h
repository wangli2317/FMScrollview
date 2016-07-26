//
//  UIView+SDAutoLayout.h
//
//  Created by gsd on 15/10/6.
//  Copyright (c) 2015年 gsd. All rights reserved.
//

// 如果需要用“断言”调试程序请打开此宏

//#define SDDebugWithAssert

#import <UIKit/UIKit.h>

@class FMAutoLayoutModel, FMUIViewCategoryManager;

@interface UIView (FMAutoLayout)

/** 开始自动布局  */
- (FMAutoLayoutModel *)fm_layout;

/** 清空之前的自动布局设置，重新开始自动布局(重新生成布局约束并使其在父view的布局序列数组中位置保持不变)  */
- (FMAutoLayoutModel *)fm_resetLayout;

/** 清空之前的自动布局设置，重新开始自动布局(重新生成布局约束并添加到父view布局序列数组中的最后一个位置)  */
- (FMAutoLayoutModel *)fm_resetNewLayout;

/** 清空之前的自动布局设置  */
- (void)fm_clearAutoLayoutSettings;

/** 将自身frame清零（一般在cell内部控件重用前调用）  */
- (void)fm_clearViewFrameCache;

/** 将自己的需要自动布局的subviews的frame(或者frame缓存)清零  */
- (void)fm_clearSubviewsAutoLayoutFrameCaches;

/** 设置固定宽度保证宽度不在自动布局过程再做中调整  */
@property (nonatomic, strong) NSNumber *fixedWidth;

/** 设置固定高度保证高度不在自动布局过程中再做调整  */
@property (nonatomic, strong) NSNumber *fixedHeight;

/** 启用cell frame缓存（可以提高cell滚动的流畅度, 目前为cell专用方法，后期会扩展到其他view） */
- (void)useCellFrameCacheWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableview;

/** 所属tableview（目前为cell专用属性，后期会扩展到其他view） */
@property (nonatomic) UITableView *fm_tableView;

/** cell的indexPath（目前为cell专用属性，后期会扩展到cell的其他子view） */
@property (nonatomic) NSIndexPath *fm_indexPath;


- (NSMutableArray *)autoLayoutModelsArray;
- (void)addAutoLayoutModel:(FMAutoLayoutModel *)model;
@property (nonatomic) FMAutoLayoutModel *ownLayoutModel;
@property (nonatomic, strong) NSNumber *fm_maxWidth;
@property (nonatomic, strong) NSNumber *autoHeightRatioValue;

@end



