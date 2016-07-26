//
//  NSObject+Utils.m
//  mogi
//
//  Created by cherry on 15/9/21.
//  Copyright (c) 2015年 com.8w4q. All rights reserved.
//

#import "NSObject+Utils.h"

@implementation NSObject (Utils)

- (BOOL) isEmpty{
    return (!self ||
            self == nil ||
            self == [NSNull null] ||
            ([self isKindOfClass:[NSString class]]&&[(NSString*)self isEqualToString:@"0"])||
            ([self isKindOfClass:[NSString class]]&&[(NSString*)self isEqualToString:@"nil"])||
            ([self isKindOfClass:[NSDictionary class]]&&([(NSDictionary*)self count]==0))||
            ([self isKindOfClass:[NSString class]]&&[(NSString*)self isEqualToString:@""]) ||
            ([self isKindOfClass:[NSMutableArray class]] && [(NSMutableArray *)self count] == 0)||
            ([self isKindOfClass:[NSArray class]] && [(NSArray *)self count] == 0) );
}
@end
