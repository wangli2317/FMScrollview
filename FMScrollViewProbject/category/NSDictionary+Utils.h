//
//  NSDictionary+Utils.h
//  mogi
//
//  Created by cherry on 15/9/21.
//  Copyright (c) 2015年 com.8w4q. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Utils.h"

@interface NSDictionary (Utils)

- (id)objectAtKey:(id)aKey;
- (id)objectAtKey:(id)aKey defvalue:(NSString*)defvalue;
- (NSString*)toFMString;


@end
