//
//  FMScrollVIew.h
//  mogi
//
//  Created by cherry on 15/12/15.
//  Copyright © 2015年 com.8w4q. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMScrollViewCell;

@protocol FMScrollViewDelegate, FMScrollViewDataSource;

@interface FMScrollView : UIScrollView

@property (nonatomic, assign, readwrite) NSInteger bufferViewFactor;
@property (nonatomic, assign, readwrite) NSString* defaultClassType;
@property (nonatomic, assign, readwrite) CGFloat columnWidth;
@property (nonatomic, assign, readwrite) NSUInteger numCols;
@property (nonatomic, assign, readwrite) NSUInteger cellMarginLeftCols;
@property (nonatomic, assign, readwrite) CGFloat cellMarginLeft;
@property (nonatomic, assign, readwrite) CGFloat cellPaddingTop;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *footerItems;

@property (readonly) BOOL reloading;

@property (nonatomic, weak) id <FMScrollViewDelegate> vdelegate;
@property (nonatomic, weak) id <FMScrollViewDataSource> vdataSource;


- (id)initWithProperties:(CGRect)frame;
- (id)initWithProperties:(CGRect)frame
              columWidth:(CGFloat)columWidth
          cellPaddingTop:(CGFloat)cellPaddingTop;
- (id)initWithProperties:(CGRect)frame
              columWidth:(CGFloat)columWidth
          cellPaddingTop:(CGFloat)cellPaddingTop
                  startY:(CGFloat)startY
      cellMarginLeftCols:(NSInteger)cellMarginLeftCols
      needPzRefreshControl:(BOOL)needPzRefreshControl;


- (void) fillFooterItems:(NSArray *)footerItems;
- (void) layoutWithStartY:(CGFloat)startY;
- (void) append:(NSMutableArray *)items;
- (void) loadMoreCompleted;
- (void) doneReloadingTableViewData;
- (void) resizeFrameAtIndex:(NSUInteger)index expandWidth:(CGFloat)expandWidth expandHeight:(CGFloat)expandHeight;
- (void) clearDataInRange:(NSRange)range;
- (void) clearDataForNew;
- (void) changeItemDataAtIndex:(NSUInteger)index object:(id)object;

- (NSUInteger) itemsCount;
- (BOOL) isExpandedAtIndex:(NSUInteger)index;
- (void)beginLoading;
- (void)finishLoading;

- (void)afterInsertAtIndex:(NSUInteger)index;

@end


#pragma mark - Delegate

@protocol FMScrollViewDelegate <NSObject>
- (void) loadMoreCompleted;
- (void) willBeginLoadingMore;
- (void) didSelectView:(FMScrollViewCell *) cell;
@optional
- (void) buttonClicked:(id)sender cell:(FMScrollViewCell *) cell;
- (void) moveItemAtIndex:(NSInteger)index toIndex:(NSInteger)newIndex;
@end

#pragma mark - DataSource

@protocol FMScrollViewDataSource <NSObject>
- (void) pullRefresh;
- (void) getMoreBricks;
@end

#pragma mark - ScrollViewPressControl

typedef enum {
    LONG_PRESS_VIEW = 1,
    TAP_PRESS_VIEW = 2,
    PAN_PRESS_VIEW = 3,
}PRESS_VIEW;

@interface ScrollViewPressControl : NSObject
+ (ScrollViewPressControl *)shareInfo;
+ (void)freeInfo;
- (void)addScrollViewPressAction:(PRESS_VIEW)view;
- (void)removeScrollViewPressAction:(PRESS_VIEW)view;
- (BOOL)isExistScrollViewPressAction:(PRESS_VIEW)view;

@property(nonatomic,copy)NSMutableArray *arrayScrollviewPressView;
@end
