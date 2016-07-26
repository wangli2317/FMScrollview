//
//  NSString+Utils.m
//  mogi
//
//  Created by cherry on 15/9/20.
//  Copyright (c) 2015年 com.8w4q. All rights reserved.
//

#import "NSString+Utils.h"
#import "NSObject+Utils.h"
#import "FMDataManager.h"

@implementation  NSString (Utils)

- (CGSize)sizeWithFont:(UIFont *)font boundingRect:(CGSize)boundingRect{
    return [self boundingRectWithSize:boundingRect options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size;
    
}

//获取当前时间戳
+ (NSInteger)getTimeSp{
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    return  [datenow timeIntervalSince1970];
    
}

@end