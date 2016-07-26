//
//  UILabel+FMLabelAutoResize.m
//  GSD_WeiXin(wechat)
//
//  Created by 王刚 on 6/4/16.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "UILabel+FMLabelAutoResize.h"
#import <objc/runtime.h>
#import "UIView+FMAutoLayout.h"
#import "FMAutoLayoutModel.h"

@implementation UILabel (FMLabelAutoResize)
- (BOOL)isAttributedContent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsAttributedContent:(BOOL)isAttributedContent{
    objc_setAssociatedObject(self, @selector(isAttributedContent), @(isAttributedContent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSingleLineAutoResizeWithMaxWidth:(CGFloat)maxWidth{
    self.fm_maxWidth = @(maxWidth);
}

- (void)setMaxNumberOfLinesToShow:(NSInteger)lineCount
{
    NSAssert(self.ownLayoutModel, @"请在布局完成之后再做此步设置！");
    if (lineCount > 0) {
        self.fm_layout.maxHeightIs(self.font.lineHeight * lineCount);
    } else {
        self.fm_layout.maxHeightIs(MAXFLOAT);
    }
}

@end
