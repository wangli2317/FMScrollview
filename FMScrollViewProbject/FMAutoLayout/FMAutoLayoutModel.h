//
//  FMAutoLayoutModel.h
//  GSD_WeiXin(wechat)
//
//  Created by 王刚 on 6/4/16.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMAutoLayoutModel,FMAutoLayoutModelItem;

typedef FMAutoLayoutModel *(^FMMarginToView)(UIView *toView, CGFloat value);
typedef FMAutoLayoutModel *(^FMMargin)(CGFloat value);
typedef FMAutoLayoutModel *(^FMMarginEqualToView)(UIView *toView);
typedef FMAutoLayoutModel *(^FMWidthHeight)(CGFloat value);
typedef FMAutoLayoutModel *(^FMWidthHeightEqualToView)(UIView *toView, CGFloat ratioValue);
typedef FMAutoLayoutModel *(^FMAutoHeight)(CGFloat ratioValue);
typedef FMAutoLayoutModel *(^FMSameWidthHeight)();
typedef void (^FMSpaceToSuperView)(UIEdgeInsets insets);

@interface FMAutoLayoutModel : NSObject
// 方法名中带有“SpaceToView”的需要传递2个参数：（UIView）参照view 和 （CGFloat）间距数值
// 方法名中带有“RatioToView”的需要传递2个参数：（UIView）参照view 和 （CGFloat）倍数
// 方法名中带有“EqualToView”的需要传递1个参数：（UIView）参照view
// 方法名中带有“Is”的需要传递1个参数：（CGFloat）数值

/** 左边到其参照view之间的间距*/
@property (nonatomic, copy, readonly) FMMarginToView leftSpaceToView;
/** 右边到其参照view之间的间距 */
@property (nonatomic, copy, readonly) FMMarginToView rightSpaceToView;
/** 顶部到其参照view之间的间距*/
@property (nonatomic, copy, readonly) FMMarginToView topSpaceToView;
/** 底部到其参照view之间的间距*/
@property (nonatomic, copy, readonly) FMMarginToView bottomSpaceToView;

/** x */
@property (nonatomic, copy, readonly) FMMargin xIs;
/** y */
@property (nonatomic, copy, readonly) FMMargin yIs;
/** centerX */
@property (nonatomic, copy, readonly) FMMargin centerXIs;
/** centerY */
@property (nonatomic, copy, readonly) FMMargin centerYIs;
/** width */
@property (nonatomic, copy, readonly) FMWidthHeight widthIs;
/** height */
@property (nonatomic, copy, readonly) FMWidthHeight heightIs;



/* 设置最大宽度和高度、最小宽度和高度 */

/** 最大宽度 */
@property (nonatomic, copy, readonly) FMWidthHeight maxWidthIs;
/** 最大高度 */
@property (nonatomic, copy, readonly) FMWidthHeight maxHeightIs;
/** 最小宽度 */
@property (nonatomic, copy, readonly) FMWidthHeight minWidthIs;
/** 最小高度 */
@property (nonatomic, copy, readonly) FMWidthHeight minHeightIs;



/* 设置和某个参照view的边距相同 */
/** 左间距与参照view相同 */
@property (nonatomic, copy, readonly) FMMarginEqualToView leftEqualToView;
/** 右间距与参照view相同 */
@property (nonatomic, copy, readonly) FMMarginEqualToView rightEqualToView;
/** 顶部间距与参照view相同 */
@property (nonatomic, copy, readonly) FMMarginEqualToView topEqualToView;
/** 底部间距与参照view相同 */
@property (nonatomic, copy, readonly) FMMarginEqualToView bottomEqualToView;
/** centerX与参照view相同 */
@property (nonatomic, copy, readonly) FMMarginEqualToView centerXEqualToView;
/** centerY与参照view相同 */
@property (nonatomic, copy, readonly) FMMarginEqualToView centerYEqualToView;



/*  设置宽度或者高度等于参照view的多少倍 */
/** 宽度是参照view宽度的多少倍 */
@property (nonatomic, copy, readonly) FMWidthHeightEqualToView widthRatioToView;
/** 高度是参照view高度的多少倍 */
@property (nonatomic, copy, readonly) FMWidthHeightEqualToView heightRatioToView;
/** 设置一个view的宽度和它的高度相同 */
@property (nonatomic, copy, readonly) FMSameWidthHeight widthEqualToHeight;
/** 设置一个view的高度和它的宽度相同 */
@property (nonatomic, copy, readonly) FMSameWidthHeight heightEqualToWidth;
/** 自适应高度，传入高宽比值，label可以传0实现文字高度自适应 */
@property (nonatomic, copy, readonly) FMAutoHeight autoHeightRatio;



/* 填充父view(快捷方法) */
/** 传入UIEdgeInsetsMake(top, left, bottom, right)，可以快捷设置view到其父view上左下右的间距  */
@property (nonatomic, copy, readonly) FMSpaceToSuperView spaceToSuperView;
@property (nonatomic, weak) UIView *needsAutoResizeView;


@property (nonatomic, strong) FMAutoLayoutModelItem *width;
@property (nonatomic, strong) FMAutoLayoutModelItem *height;
@property (nonatomic, strong) FMAutoLayoutModelItem *left;
@property (nonatomic, strong) FMAutoLayoutModelItem *top;
@property (nonatomic, strong) FMAutoLayoutModelItem *right;
@property (nonatomic, strong) FMAutoLayoutModelItem *bottom;
@property (nonatomic, strong) NSNumber *centerX;
@property (nonatomic, strong) NSNumber *centerY;

@property (nonatomic, strong) NSNumber *maxWidth;
@property (nonatomic, strong) NSNumber *maxHeight;
@property (nonatomic, strong) NSNumber *minWidth;
@property (nonatomic, strong) NSNumber *minHeight;

@property (nonatomic, strong) FMAutoLayoutModelItem *ratio_width;
@property (nonatomic, strong) FMAutoLayoutModelItem *ratio_height;
@property (nonatomic, strong) FMAutoLayoutModelItem *ratio_left;
@property (nonatomic, strong) FMAutoLayoutModelItem *ratio_top;
@property (nonatomic, strong) FMAutoLayoutModelItem *ratio_right;
@property (nonatomic, strong) FMAutoLayoutModelItem *ratio_bottom;

@property (nonatomic, strong) FMAutoLayoutModelItem *equalLeft;
@property (nonatomic, strong) FMAutoLayoutModelItem *equalRight;
@property (nonatomic, strong) FMAutoLayoutModelItem *equalTop;
@property (nonatomic, strong) FMAutoLayoutModelItem *equalBottom;
@property (nonatomic, strong) FMAutoLayoutModelItem *equalCenterX;
@property (nonatomic, strong) FMAutoLayoutModelItem *equalCenterY;

@property (nonatomic, strong) FMAutoLayoutModelItem *widthEqualHeight;
@property (nonatomic, strong) FMAutoLayoutModelItem *heightEqualWidth;
@end

