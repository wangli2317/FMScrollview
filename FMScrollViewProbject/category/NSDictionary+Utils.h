//
//  NSDictionary+Utils.h
//  mogi
//
//  Created by 王刚 on 9/5/16.
//  Copyright © 2016年 王刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Utils.h"

@interface NSDictionary (Utils)

- (id)objectAtKey:(id)aKey;
- (id)objectAtKey:(id)aKey defvalue:(NSString*)defvalue;
- (NSString*)toFMString;


@end
