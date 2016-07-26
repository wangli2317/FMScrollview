//
//  UILabel+FMLabelAutoResize.h
//  GSD_WeiXin(wechat)
//
//  Created by 王刚 on 6/4/16.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FMLabelAutoResize)
/** 是否是attributedString */
@property (nonatomic) BOOL isAttributedContent;

/** 设置单行文本label宽度自适应 */
- (void)setSingleLineAutoResizeWithMaxWidth:(CGFloat)maxWidth;

/** 设置label最多可以显示多少行，如果传0则显示所有行文字 */
- (void)setMaxNumberOfLinesToShow:(NSInteger)lineCount;
@end
