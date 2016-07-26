//
//  FMAutoLayoutModel.m
//  GSD_WeiXin(wechat)
//
//  Created by 王刚 on 6/4/16.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "FMAutoLayoutModel.h"
#import "FMAutoLayoutModelItem.h"
#import "UIView+FMChangeFrame.h"
#import "UIView+FMAutoLayout.h"

@interface FMAutoLayoutModel()
@end

@implementation FMAutoLayoutModel

@synthesize leftSpaceToView = _leftSpaceToView;
@synthesize rightSpaceToView = _rightSpaceToView;
@synthesize topSpaceToView = _topSpaceToView;
@synthesize bottomSpaceToView = _bottomSpaceToView;
@synthesize widthIs = _widthIs;
@synthesize heightIs = _heightIs;
@synthesize widthRatioToView = _widthRatioToView;
@synthesize heightRatioToView = _heightRatioToView;
@synthesize leftEqualToView = _leftEqualToView;
@synthesize rightEqualToView = _rightEqualToView;
@synthesize topEqualToView = _topEqualToView;
@synthesize bottomEqualToView = _bottomEqualToView;
@synthesize centerXEqualToView = _centerXEqualToView;
@synthesize centerYEqualToView = _centerYEqualToView;
@synthesize xIs = _xIs;
@synthesize yIs = _yIs;
@synthesize centerXIs = _centerXIs;
@synthesize centerYIs = _centerYIs;
@synthesize autoHeightRatio = _autoHeightRatio;
@synthesize spaceToSuperView = _spaceToSuperView;
@synthesize maxWidthIs = _maxWidthIs;
@synthesize maxHeightIs = _maxHeightIs;
@synthesize minWidthIs = _minWidthIs;
@synthesize minHeightIs = _minHeightIs;
@synthesize widthEqualToHeight = _widthEqualToHeight;
@synthesize heightEqualToWidth = _heightEqualToWidth;

- (FMMarginToView)leftSpaceToView{
    if (!_leftSpaceToView) {
        _leftSpaceToView = [self marginToViewblockWithKey:@"left"];
    }
    return _leftSpaceToView;
}

- (FMMarginToView)rightSpaceToView{
    if (!_rightSpaceToView) {
        _rightSpaceToView = [self marginToViewblockWithKey:@"right"];
    }
    return _rightSpaceToView;
}

- (FMMarginToView)topSpaceToView{
    if (!_topSpaceToView) {
        _topSpaceToView = [self marginToViewblockWithKey:@"top"];
    }
    return _topSpaceToView;
}

- (FMMarginToView)bottomSpaceToView{
    if (!_bottomSpaceToView) {
        _bottomSpaceToView = [self marginToViewblockWithKey:@"bottom"];
    }
    return _bottomSpaceToView;
}

- (FMMarginToView)marginToViewblockWithKey:(NSString *)key{
    __weak typeof(self) weakSelf = self;
    return ^(UIView *view, CGFloat value) {
        FMAutoLayoutModelItem *item = [FMAutoLayoutModelItem new];
        item.value = @(value);
        item.refView = view;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

- (FMWidthHeight)widthIs{
    if (!_widthIs) {
        __weak typeof(self) weakSelf = self;
        _widthIs = ^(CGFloat value) {
            weakSelf.needsAutoResizeView.width = value;
            weakSelf.needsAutoResizeView.fixedWidth = @(value);
            return weakSelf;
        };
    }
    return _widthIs;
}

- (FMWidthHeight)heightIs{
    if (!_heightIs) {
        __weak typeof(self) weakSelf = self;
        _heightIs = ^(CGFloat value) {
            weakSelf.needsAutoResizeView.height = value;
            weakSelf.needsAutoResizeView.fixedHeight = @(value);
            return weakSelf;
        };
    }
    return _heightIs;
}

- (FMWidthHeightEqualToView)widthRatioToView{
    if (!_widthRatioToView) {
        __weak typeof(self) weakSelf = self;
        _widthRatioToView = ^(UIView *view, CGFloat value) {
            weakSelf.ratio_width = [FMAutoLayoutModelItem new];
            weakSelf.ratio_width.value = @(value);
            weakSelf.ratio_width.refView = view;
            return weakSelf;
        };
    }
    return _widthRatioToView;
}

- (FMWidthHeightEqualToView)heightRatioToView{
    if (!_heightRatioToView) {
        __weak typeof(self) weakSelf = self;
        _heightRatioToView = ^(UIView *view, CGFloat value) {
            weakSelf.ratio_height = [FMAutoLayoutModelItem new];
            weakSelf.ratio_height.refView = view;
            weakSelf.ratio_height.value = @(value);
            return weakSelf;
        };
    }
    return _heightRatioToView;
}

- (FMWidthHeight)maxWidthIs{
    if (!_maxWidthIs) {
        _maxWidthIs = [self limitingWidthHeightWithKey:@"maxWidth"];
    }
    return _maxWidthIs;
}

- (FMWidthHeight)maxHeightIs{
    if (!_maxHeightIs) {
        _maxHeightIs = [self limitingWidthHeightWithKey:@"maxHeight"];
    }
    return _maxHeightIs;
}

- (FMWidthHeight)minWidthIs{
    if (!_minWidthIs) {
        _minWidthIs = [self limitingWidthHeightWithKey:@"minWidth"];
    }
    return _minWidthIs;
}

- (FMWidthHeight)minHeightIs{
    if (!_minHeightIs) {
        _minHeightIs = [self limitingWidthHeightWithKey:@"minHeight"];
    }
    return _minHeightIs;
}


- (FMWidthHeight)limitingWidthHeightWithKey:(NSString *)key{
    __weak typeof(self) weakSelf = self;
    
    return ^(CGFloat value) {
        [weakSelf setValue:@(value) forKey:key];
        
        return weakSelf;
    };
}


- (FMMarginEqualToView)marginEqualToViewBlockWithKey:(NSString *)key{
    __weak typeof(self) weakSelf = self;
    
    return ^(UIView *view) {
        FMAutoLayoutModelItem *item = [FMAutoLayoutModelItem new];
        item.refView = view;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

- (FMMarginEqualToView)leftEqualToView{
    if (!_leftEqualToView) {
        _leftEqualToView = [self marginEqualToViewBlockWithKey:@"equalLeft"];
    }
    return _leftEqualToView;
}

- (FMMarginEqualToView)rightEqualToView{
    if (!_rightEqualToView) {
        _rightEqualToView = [self marginEqualToViewBlockWithKey:@"equalRight"];
    }
    return _rightEqualToView;
}

- (FMMarginEqualToView)topEqualToView{
    if (!_topEqualToView) {
        _topEqualToView = [self marginEqualToViewBlockWithKey:@"equalTop"];
    }
    return _topEqualToView;
}

- (FMMarginEqualToView)bottomEqualToView{
    if (!_bottomEqualToView) {
        _bottomEqualToView = [self marginEqualToViewBlockWithKey:@"equalBottom"];
    }
    return _bottomEqualToView;
}

- (FMMarginEqualToView)centerXEqualToView{
    if (!_centerXEqualToView) {
        _centerXEqualToView = [self marginEqualToViewBlockWithKey:@"equalCenterX"];
    }
    return _centerXEqualToView;
}

- (FMMarginEqualToView)centerYEqualToView{
    if (!_centerYEqualToView) {
        _centerYEqualToView = [self marginEqualToViewBlockWithKey:@"equalCenterY"];
    }
    return _centerYEqualToView;
}


- (FMMargin)marginBlockWithKey:(NSString *)key{
    __weak typeof(self) weakSelf = self;
    
    return ^(CGFloat value) {
        
        if ([key isEqualToString:@"x"]) {
            weakSelf.needsAutoResizeView.left = value;
        } else if ([key isEqualToString:@"y"]) {
            weakSelf.needsAutoResizeView.top = value;
        } else if ([key isEqualToString:@"centerX"]) {
            weakSelf.centerX = @(value);
        } else if ([key isEqualToString:@"centerY"]) {
            weakSelf.centerY = @(value);
        }
        
        return weakSelf;
    };
}

- (FMMargin)xIs{
    if (!_xIs) {
        _xIs = [self marginBlockWithKey:@"x"];
    }
    return _xIs;
}

- (FMMargin)yIs{
    if (!_yIs) {
        _yIs = [self marginBlockWithKey:@"y"];
    }
    return _yIs;
}

- (FMMargin)centerXIs{
    if (!_centerXIs) {
        _centerXIs = [self marginBlockWithKey:@"centerX"];
    }
    return _centerXIs;
}

- (FMMargin)centerYIs{
    if (!_centerYIs) {
        _centerYIs = [self marginBlockWithKey:@"centerY"];
    }
    return _centerYIs;
}

- (FMAutoHeight)autoHeightRatio{
    __weak typeof(self) weakSelf = self;
    
    if (!_autoHeightRatio) {
        _autoHeightRatio = ^(CGFloat ratioaValue) {
            weakSelf.needsAutoResizeView.autoHeightRatioValue = @(ratioaValue);
            return weakSelf;
        };
    }
    return _autoHeightRatio;
}

- (FMSpaceToSuperView)spaceToSuperView{
    __weak typeof(self) weakSelf = self;
    
    if (!_spaceToSuperView) {
        _spaceToSuperView = ^(UIEdgeInsets insets) {
            UIView *superView = weakSelf.needsAutoResizeView.superview;
            if (superView) {
                weakSelf.needsAutoResizeView.fm_layout
                .leftSpaceToView(superView, insets.left)
                .topSpaceToView(superView, insets.top)
                .rightSpaceToView(superView, insets.right)
                .bottomSpaceToView(superView, insets.bottom);
            }
        };
    }
    return _spaceToSuperView;
}

- (FMSameWidthHeight)widthEqualToHeight{
    __weak typeof(self) weakSelf = self;
    
    if (!_widthEqualToHeight) {
        _widthEqualToHeight = ^() {
            weakSelf.widthEqualHeight = [FMAutoLayoutModelItem new];
            // 主动触发一次赋值操作
            weakSelf.needsAutoResizeView.height = weakSelf.needsAutoResizeView.height;
            return weakSelf;
        };
    }
    return _widthEqualToHeight;
}

- (FMSameWidthHeight)heightEqualToWidth{
    __weak typeof(self) weakSelf = self;
    
    if (!_heightEqualToWidth) {
        _heightEqualToWidth = ^() {
            weakSelf.heightEqualWidth = [FMAutoLayoutModelItem new];
            // 主动触发一次赋值操作
            weakSelf.needsAutoResizeView.width = weakSelf.needsAutoResizeView.width;
            return weakSelf;
        };
    }
    return _heightEqualToWidth;
}

@end
