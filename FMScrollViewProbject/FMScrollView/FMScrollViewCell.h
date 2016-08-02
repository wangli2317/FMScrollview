//
//  FMScrollViewCell.h
//  mogi
//
//  Created by 王刚 on 9/5/16.
//  Copyright © 2016年 王刚. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FMScrollView;

@interface FMScrollViewCell : UIView

@property (nonatomic, strong) id object;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL canBeMovedToLeft;
@property (nonatomic, assign) CGFloat canBeMovedToLeftWidth;
@property (nonatomic, assign) BOOL canBeLongPress;

- (void)initView:(id)object frame:(CGRect)frame;
- (void)prepareForReuse;
- (void)cellAppear;
- (void)cellRefreshAppearWithObject:(id)object;
- (void)resizeFrameWithExpandWidth:(CGFloat)expandWidth expandHeight:(CGFloat)expandHeight;
- (void)movedToLeftViewWithOffsetX:(CGFloat)x orgFrame:(CGRect)orgFrame;

+ (BOOL)fixedCell;

+ (CGFloat)calculateWidth:(id)object view:(FMScrollView*)view;
+ (CGFloat)calculateHeight:(id)object view:(FMScrollView*)view;
+ (CGFloat)heightOffset:(id)object view:(FMScrollView*)view;
+ (CGFloat)xOffset:(id)object view:(FMScrollView*)view;

@end
