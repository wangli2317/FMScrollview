//
//  PZRefreshControlDefaultStyle.m
//  PullToRefreshControlDemo
//
//  Created by cherry on 16/1/12.
//  Copyright © 2016年 onightjar.com. All rights reserved.
//

#import "PZRefreshControlDefaultStyle.h"
#import "FMConfigure.h"

@implementation PZRefreshControlDefaultStyle

+ (UIColor *)ptrLayerColor{
    return [UIColor redColor];
}
+ (UIColor *)loadingLayerColor{
    return [UIColor redColor];
}
+ (UIColor *)tipColor{
    return [UIColor grayColor];
}
+ (UIColor *)keywordColor{
    return [UIColor redColor];
}

+ (UIFont *)keywordFont{
    return [UIFont systemFontOfSize:11];
}
+ (UIFont *)tipFont{
    return [UIFont systemFontOfSize:12];
}

+ (NSArray *)tipsArray{

    NSString * tipsString = @"啦啦|嘻嘻|呵呵|家具啊";
    NSArray * array = [tipsString componentsSeparatedByString:@"|"];
    
    return array;
}
+ (NSArray *)keywordArray{

    NSString * tipsString =  @"啦啦|嘻嘻|呵呵|家具啊";
    NSArray * array = [tipsString componentsSeparatedByString:@"|"];
    
    return array;
}


@end
