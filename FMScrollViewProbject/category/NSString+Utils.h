//
//  NSString+Utils.h
//  mogi
//
//  Created by cherry on 15/9/20.
//  Copyright (c) 2015年 com.8w4q. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Utils)

-(CGSize)sizeWithFont:(UIFont *)font boundingRect:(CGSize)boundingRect;

+ (NSInteger)getTimeSp;
@end
