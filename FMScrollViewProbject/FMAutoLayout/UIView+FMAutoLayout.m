//
//  UIView+FMAutoLayout.m
//
//  Created by gsd on 15/10/6.
//  Copyright (c) 2015年 王刚. All rights reserved.
//

#import "UIView+FMAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "FMAutoLayoutModel.h"
#import <objc/runtime.h>
#import "FMUIViewCategoryManager.h"
#import "UIView+FMAutoHeightWidth.h"
#import "UIView+FMLayoutExtention.h"
#import "UIView+FMChangeFrame.h"
#import "FMAutoLayoutModelItem.h"
#import "UILabel+FMLabelAutoResize.h"

@implementation UIView (FMAutoLayout)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *selStringsArray = @[@"layoutSubviews"];
        
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *mySelString = [@"fm_" stringByAppendingString:selString];
            
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
            method_exchangeImplementations(originalMethod, myMethod);
        }];
    });
}

#pragma mark - properties

- (NSMutableArray *)autoLayoutModelsArray{
    if (!objc_getAssociatedObject(self, _cmd)) {
        objc_setAssociatedObject(self, _cmd, [NSMutableArray array], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (NSNumber *)fixedWidth{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFixedWidth:(NSNumber *)fixedWidth{
    if (fixedWidth) {
        self.width = [fixedWidth floatValue];
    }
    objc_setAssociatedObject(self, @selector(fixedWidth), fixedWidth, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)fixedHeight{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFixedHeight:(NSNumber *)fixedHeight{
    if (fixedHeight) {
        self.height = [fixedHeight floatValue];
    }
    objc_setAssociatedObject(self, @selector(fixedHeight), fixedHeight, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)autoHeightRatioValue{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAutoHeightRatioValue:(NSNumber *)autoHeightRatioValue{
    objc_setAssociatedObject(self, @selector(autoHeightRatioValue), autoHeightRatioValue, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)fm_maxWidth{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFm_maxWidth:(NSNumber *)fm_maxWidth{
    objc_setAssociatedObject(self, @selector(fm_maxWidth), fm_maxWidth, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)useCellFrameCacheWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableview{
    self.fm_indexPath = indexPath;
    self.fm_tableView = tableview;
}

- (UITableView *)fm_tableView{
    return self.fm_categoryManager.fm_tableView;
}

- (void)setFm_tableView:(UITableView *)fm_tableView{
    if ([self isKindOfClass:[UITableViewCell class]]) {
        [(UITableViewCell *)self contentView].fm_tableView = fm_tableView;
    }
    self.fm_categoryManager.fm_tableView = fm_tableView;
}

- (NSIndexPath *)fm_indexPath{
    return self.fm_categoryManager.fm_indexPath;
}

- (void)setFm_indexPath:(NSIndexPath *)fm_indexPath{
    if ([self isKindOfClass:[UITableViewCell class]]) {
        [(UITableViewCell *)self contentView].fm_indexPath = fm_indexPath;
    }
    self.fm_categoryManager.fm_indexPath = fm_indexPath;
}

- (FMAutoLayoutModel *)ownLayoutModel{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOwnLayoutModel:(FMAutoLayoutModel *)ownLayoutModel{
    objc_setAssociatedObject(self, @selector(ownLayoutModel), ownLayoutModel, OBJC_ASSOCIATION_RETAIN);
}

- (FMAutoLayoutModel *)fm_layout{
#ifdef SDDebugWithAssert
    /*
     卡在这里说明你的要自动布局的view在没有添加到父view的情况下就开始设置布局,你需要这样：
     1.  UIView *view = [UIView new];
     2.  [superView addSubview:view];
     3.  view.fm_layout
     .leftEqualToView()...
     */
    NSAssert(self.superview, @">>>>>>>>>在加入父view之后才可以做自动布局设置");
#endif
    FMAutoLayoutModel *model = [self ownLayoutModel];
    if (!model) {
        model = [FMAutoLayoutModel new];
        model.needsAutoResizeView = self;
        [self setOwnLayoutModel:model];
        [self.superview.autoLayoutModelsArray addObject:model];
    }
    return model;
}

- (FMAutoLayoutModel *)fm_resetLayout{
    FMAutoLayoutModel *model = [self ownLayoutModel];
    FMAutoLayoutModel *newModel = [FMAutoLayoutModel new];
    newModel.needsAutoResizeView = self;
    [self fm_clearViewFrameCache];
    NSInteger index = 0;
    if (model) {
        index = [self.superview.autoLayoutModelsArray indexOfObject:model];
        [self.superview.autoLayoutModelsArray replaceObjectAtIndex:index withObject:newModel];
    } else {
        [self.superview.autoLayoutModelsArray addObject:newModel];
    }
    [self setOwnLayoutModel:newModel];
    [self fm_clearExtraAutoLayoutItems];
    return newModel;
}

- (FMAutoLayoutModel *)fm_resetNewLayout{
    [self fm_clearAutoLayoutSettings];
    [self fm_clearExtraAutoLayoutItems];
    return [self fm_layout];
}

- (void)fm_clearAutoLayoutSettings{
    FMAutoLayoutModel *model = [self ownLayoutModel];
    if (model) {
        [self.superview.autoLayoutModelsArray removeObject:model];
        [self setOwnLayoutModel:nil];
    }
    [self fm_clearExtraAutoLayoutItems];
}

- (void)fm_clearExtraAutoLayoutItems{
    if (self.autoHeightRatioValue) {
        self.autoHeightRatioValue = nil;
    }
    self.fixedHeight = nil;
    self.fixedWidth = nil;
}

- (void)fm_clearViewFrameCache{
    self.frame = CGRectZero;
}

- (void)fm_clearSubviewsAutoLayoutFrameCaches{
    if (self.fm_tableView && self.fm_indexPath) {
        [self.fm_tableView.cellAutoHeightManager clearHeightCacheOfIndexPaths:@[self.fm_indexPath]];
        return;
    }
    
    if (self.autoLayoutModelsArray.count == 0) return;
    
    [self.autoLayoutModelsArray enumerateObjectsUsingBlock:^(FMAutoLayoutModel *model, NSUInteger idx, BOOL *stop) {
        model.needsAutoResizeView.frame = CGRectZero;
    }];
}

- (void)fm_layoutSubviews{
    [self fm_layoutSubviews];
    
    if (self.fm_equalWidthSubviews.count) {
        __block CGFloat totalMargin = 0;
        [self.fm_equalWidthSubviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            FMAutoLayoutModel *model = view.fm_layout;
            CGFloat left = model.left ? [model.left.value floatValue] : model.needsAutoResizeView.left;
            totalMargin += (left + [model.right.value floatValue]);
        }];
        CGFloat averageWidth = (self.width - totalMargin) / self.fm_equalWidthSubviews.count;
        [self.fm_equalWidthSubviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            view.width = averageWidth;
            view.fixedWidth = @(averageWidth);
        }];
    }
    
    if (self.autoLayoutModelsArray.count) {
        
        NSMutableArray *caches = nil;
        
        if ([self isKindOfClass:NSClassFromString(@"UITableViewCellContentView")] && self.fm_tableView) {
            caches = [self.fm_tableView.cellAutoHeightManager subviewFrameCachesWithIndexPath:self.fm_indexPath];
        }
        
        [self.autoLayoutModelsArray enumerateObjectsUsingBlock:^(FMAutoLayoutModel *model, NSUInteger idx, BOOL *stop) {
            if (idx < caches.count) {
                model.needsAutoResizeView.frame = [[caches objectAtIndex:idx] CGRectValue];
                [self setupCornerRadiusWithView:model.needsAutoResizeView model:model];
            } else {
                [self fm_resizeWithModel:model];
            }
        }];
    }
    
    if (self.tag == kSDModelCellTag && [self isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
        UITableViewCell *cell = (UITableViewCell *)(self.superview);
        if ([cell isKindOfClass:NSClassFromString(@"UITableViewCellScrollView")]) {
            cell = (UITableViewCell *)cell.superview;
        }
        if ([cell isKindOfClass:[UITableViewCell class]]) {
            CGFloat height = 0;
            for (UIView *view in cell.fm_bottomViewsArray
                 ) {
                height = MAX(height, view.bottom);
            }
            cell.autoHeight = height + cell.fm_bottomViewBottomMargin;
        }
    } else if (![self isKindOfClass:[UITableViewCell class]] && (self.fm_bottomViewsArray.count || self.fm_rightViewsArray.count)) {
        CGFloat contentHeight = 0;
        CGFloat contentWidth = 0;
        if (self.fm_bottomViewsArray) {
            CGFloat height = 0;
            for (UIView *view in self.fm_bottomViewsArray) {
                height = MAX(height, view.bottom);
            }
            contentHeight = height + self.fm_bottomViewBottomMargin;
        }
        if (self.fm_rightViewsArray) {
            CGFloat width = 0;
            for (UIView *view in self.fm_rightViewsArray) {
                width = MAX(width, view.right);
            }
            contentWidth = width + self.fm_rightViewRightMargin;
        }
        if ([self isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)self;
            CGSize contentSize = scrollView.contentSize;
            if (contentHeight > 0) {
                contentSize.height = contentHeight;
            }
            if (contentWidth > 0) {
                contentSize.width = contentWidth;
            }
            if (contentSize.width <= 0) {
                contentSize.width = scrollView.width;
            }
            if (!CGSizeEqualToSize(contentSize, scrollView.contentSize)) {
                scrollView.contentSize = contentSize;
            }
        } else {
            // 如果这里出现循环调用情况请把demo发送到gsdios@126.com，谢谢配合。
            if (self.fm_bottomViewsArray.count && (floorf(contentHeight) != floorf(self.height))) {
                self.height = contentHeight;
                self.fixedHeight = @(self.height);
            }
            
            if (self.fm_rightViewsArray.count && (floorf(contentWidth) != floorf(self.width))) {
                self.width = contentWidth;
                self.fixedWidth = @(self.width);
            }
        }
        
        if (![self isKindOfClass:[UIScrollView class]] && self.fm_rightViewsArray.count && (self.ownLayoutModel.right || self.ownLayoutModel.equalRight)) {
            [self layoutRightWithView:self model:self.ownLayoutModel];
        }
        
        if (![self isKindOfClass:[UIScrollView class]] && self.fm_bottomViewsArray.count && (self.ownLayoutModel.bottom || self.ownLayoutModel.equalBottom)) {
            [self layoutBottomWithView:self model:self.ownLayoutModel];
        }
        
        if (self.didFinishAutoLayoutBlock) {
            self.didFinishAutoLayoutBlock(self.frame);
        }
    }
}

- (void)fm_resizeWithModel:(FMAutoLayoutModel *)model{
    UIView *view = model.needsAutoResizeView;
    
    if (!view) return;
    
    if (view.fm_maxWidth && (model.rightSpaceToView || model.rightEqualToView)) { // 靠右布局前提设置
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            CGFloat width = [view.fm_maxWidth floatValue] > 0 ? [view.fm_maxWidth floatValue] : MAXFLOAT;
            label.numberOfLines = 1;
            if (label.text.length) {
                if (!label.isAttributedContent) {
                    CGRect rect = [label.text boundingRectWithSize:CGSizeMake(width, label.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : label.font} context:nil];
                    label.width = rect.size.width;
                } else{
                    [label sizeToFit];
                    if (label.width > width) {
                        label.width = width;
                    }
                }
                label.fixedWidth = @(label.width);
            } else {
                label.width = 0;
            }
        }
    }
    
    if (model.width) {
        view.width = [model.width.value floatValue];
        view.fixedWidth = @(view.width);
    } else if (model.ratio_width) {
        view.width = model.ratio_width.refView.width * [model.ratio_width.value floatValue];
        view.fixedWidth = @(view.width);
    }
    
    if (model.height) {
        view.height = [model.height.value floatValue];
        view.fixedHeight = @(view.height);
    } else if (model.ratio_height) {
        view.height = [model.ratio_height.value floatValue] * model.ratio_height.refView.height;
        view.fixedHeight = @(view.height);
    }
    
    if (model.left) {
        if (view.superview == model.left.refView) {
            if (!view.fixedWidth) { // view.autoLeft && view.autoRight
                view.width = view.right - [model.left.value floatValue];
            }
            view.left = [model.left.value floatValue];
        } else {
            if (!view.fixedWidth) { // view.autoLeft && view.autoRight
                view.width = view.right - model.left.refView.right - [model.left.value floatValue];
            }
            view.left = model.left.refView.right + [model.left.value floatValue];
        }
        
    } else if (model.equalLeft) {
        if (!view.fixedWidth) {
            view.width = view.right - model.equalLeft.refView.left;
        }
        if (view.superview == model.equalLeft.refView) {
            view.left = 0;
        } else {
            view.left = model.equalLeft.refView.left;
        }
    } else if (model.equalCenterX) {
        if (view.superview == model.equalCenterX.refView) {
            view.centerX = model.equalCenterX.refView.width * 0.5;
        } else {
            view.centerX = model.equalCenterX.refView.centerX;
        }
    } else if (model.centerX) {
        view.centerX = [model.centerX floatValue];
    }
    
    [self layoutRightWithView:view model:model];
    
    if (view.autoHeightRatioValue && view.width > 0 && (model.bottomEqualToView || model.bottomSpaceToView)) { // 底部布局前提设置
        if ([view.autoHeightRatioValue floatValue] > 0) {
            view.height = view.width * [view.autoHeightRatioValue floatValue];
        } else {
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)view;
                if (model.top || model.equalTop) {
                    model.bottom = nil;
                    model.equalBottom = nil;
                }
                label.numberOfLines = 0;
                if (label.text.length) {
                    if (!label.isAttributedContent) {
                        CGRect rect = [label.text boundingRectWithSize:CGSizeMake(label.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : label.font} context:nil];
                        label.height = rect.size.height;
                    } else {
                        [label sizeToFit];
                    }
                    label.fixedHeight = @(label.height);
                } else {
                    label.height = 0;
                }
            } else {
                view.height = 0;
            }
        }
    }
    
    
    if (model.top) {
        if (view.superview == model.top.refView) {
            if (!view.fixedHeight) { // view.autoTop && view.autoBottom && view.bottom
                view.height = view.bottom - [model.top.value floatValue];
            }
            view.top = [model.top.value floatValue];
        } else {
            if (!view.fixedHeight) { // view.autoTop && view.autoBottom && view.bottom
                view.height = view.bottom - model.top.refView.bottom - [model.top.value floatValue];
            }
            view.top = model.top.refView.bottom + [model.top.value floatValue];
        }
    } else if (model.equalTop) {
        if (view.superview == model.equalTop.refView) {
            if (!view.fixedHeight) {
                view.height = view.bottom;
            }
            view.top = 0;
        } else {
            if (!view.fixedHeight) {
                view.height = view.bottom - model.equalTop.refView.top;
            }
            view.top = model.equalTop.refView.top;
        }
    } else if (model.equalCenterY) {
        if (view.superview == model.equalCenterY.refView) {
            view.centerY = model.equalCenterY.refView.height * 0.5;
        } else {
            view.centerY = model.equalCenterY.refView.centerY;
        }
    } else if (model.centerY) {
        view.centerY = [model.centerY floatValue];
    }
    
    [self layoutBottomWithView:view model:model];
    
    if (view.fm_maxWidth) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            CGFloat width = [view.fm_maxWidth floatValue] > 0 ? [view.fm_maxWidth floatValue] : MAXFLOAT;
            label.numberOfLines = 1;
            if (label.text.length) {
                if (!label.isAttributedContent) {
                    CGRect rect = [label.text boundingRectWithSize:CGSizeMake(width, label.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : label.font} context:nil];
                    label.width = rect.size.width;
                    label.fixedWidth = @(label.width);
                } else{
                    [label sizeToFit];
                    if (label.width > width) {
                        label.width = width;
                    }
                }
            } else {
                label.width = 0;
            }
        }
    }
    
    if (model.maxWidth && [model.maxWidth floatValue] < view.width) {
        view.width = [model.maxWidth floatValue];
    }
    
    if (model.minWidth && [model.minWidth floatValue] > view.width) {
        view.width = [model.minWidth floatValue];
    }
    
    if (view.autoHeightRatioValue && view.width > 0) {
        if ([view.autoHeightRatioValue floatValue] > 0) {
            view.height = view.width * [view.autoHeightRatioValue floatValue];
        } else {
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)view;
                label.numberOfLines = 0;
                if (label.text.length) {
                    if (!label.isAttributedContent) {
                        CGRect rect = [label.text boundingRectWithSize:CGSizeMake(label.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : label.font} context:nil];
                        label.height = rect.size.height;
                    } else {
                        [label sizeToFit];
                    }
                } else {
                    label.height = 0;
                }
            } else {
                view.height = 0;
            }
        }
    }
    
    if (model.maxHeight && [model.maxHeight floatValue] < view.height) {
        view.height = [model.maxHeight floatValue];
    }
    
    if (model.minHeight && [model.minHeight floatValue] > view.height) {
        view.height = [model.minHeight floatValue];
    }
    
    if (model.widthEqualHeight) {
        view.width = view.height;
    }
    
    if (model.heightEqualWidth) {
        view.height = view.width;
    }
    
    if (view.didFinishAutoLayoutBlock) {
        view.didFinishAutoLayoutBlock(view.frame);
    }
    
    if (view.fm_bottomViewsArray.count || view.fm_rightViewsArray.count) {
        [view layoutSubviews];
    }
    
    
    [self setupCornerRadiusWithView:view model:model];
    
}

- (void)layoutRightWithView:(UIView *)view model:(FMAutoLayoutModel *)model{
    if (model.right) {
        if (view.superview == model.right.refView) {
            if (!view.fixedWidth) { // view.autoLeft && view.autoRight
                view.width = model.right.refView.width - view.left - [model.right.value floatValue];
            }
            view.right = model.right.refView.width - [model.right.value floatValue];
        } else {
            if (!view.fixedWidth) { // view.autoLeft && view.autoRight
                view.width =  model.right.refView.left - view.left - [model.right.value floatValue];
            }
            view.right = model.right.refView.left - [model.right.value floatValue];
        }
    } else if (model.equalRight) {
        if (!view.fixedWidth) {
            if (model.equalRight.refView == view.superview) {
                view.width = model.equalRight.refView.width - view.left;
            } else {
                view.width = model.equalRight.refView.right - view.left;
            }
        }
        
        view.right = model.equalRight.refView.right;
        if (view.superview == model.equalRight.refView) {
            view.right = model.equalRight.refView.width;
        }
        
    }
}

- (void)layoutBottomWithView:(UIView *)view model:(FMAutoLayoutModel *)model{
    if (model.bottom) {
        if (view.superview == model.bottom.refView) {
            if (!view.fixedHeight) {
                view.height = view.superview.height - view.top - [model.bottom.value floatValue];
            }
            view.bottom = model.bottom.refView.height - [model.bottom.value floatValue];
        } else {
            if (!view.fixedHeight) {
                view.height = model.bottom.refView.top - view.top - [model.bottom.value floatValue];
            }
            view.bottom = model.bottom.refView.top - [model.bottom.value floatValue];
        }
        
    } else if (model.equalBottom) {
        if (view.superview == model.equalBottom.refView) {
            if (!view.fixedHeight) {
                view.height = view.superview.height - view.top;
            }
            view.bottom = model.equalBottom.refView.height;
        } else {
            if (!view.fixedHeight) {
                view.height = model.equalBottom.refView.bottom - view.top;
            }
            view.bottom = model.equalBottom.refView.bottom;
        }
    }
}


- (void)setupCornerRadiusWithView:(UIView *)view model:(FMAutoLayoutModel *)model{
    CGFloat cornerRadius = view.layer.cornerRadius;
    CGFloat newCornerRadius = 0;
    
    if (view.fm_cornerRadius && (cornerRadius != [view.fm_cornerRadius floatValue])) {
        newCornerRadius = [view.fm_cornerRadius floatValue];
    } else if (view.fm_cornerRadiusFromWidthRatio && (cornerRadius != [view.fm_cornerRadiusFromWidthRatio floatValue] * view.width)) {
        newCornerRadius = view.width * [view.fm_cornerRadiusFromWidthRatio floatValue];
    } else if (view.fm_cornerRadiusFromHeightRatio && (cornerRadius != view.height * [view.fm_cornerRadiusFromHeightRatio floatValue])) {
        newCornerRadius = view.height * [view.fm_cornerRadiusFromHeightRatio floatValue];
    }
    
    if (newCornerRadius > 0) {
        view.layer.cornerRadius = newCornerRadius;
        view.clipsToBounds = YES;
    }
}

- (void)addAutoLayoutModel:(FMAutoLayoutModel *)model{
    [self.autoLayoutModelsArray addObject:model];
}

@end

