//
//  NSDictionary+Utils.m
//  mogi
//
//  Created by cherry on 15/9/21.
//  Copyright (c) 2015年 com.8w4q. All rights reserved.
//

#import "NSDictionary+Utils.h"

@implementation NSDictionary (Utils)
- (id)objectAtKey:(id)aKey{
    NSObject *obj = [self objectForKey:aKey];
    if(obj.isEmpty){
        return [obj isKindOfClass:[NSArray class]]?[[NSArray alloc]init]:@"";
    }else{
        return obj;
    }
}
- (id)objectAtKey:(id)aKey defvalue:(NSString*)defvalue{
    NSObject *obj = [self objectForKey:aKey];
    if(obj.isEmpty){
        return [obj isKindOfClass:[NSArray class]]?[[NSArray alloc]init ]:defvalue;
    }else{
        return obj;
    }
}

- (NSString*)toFMString{

    
    NSMutableArray * resultArray = [NSMutableArray array];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString * str = [NSString stringWithFormat:@"%@:%@",key,obj];
        
        [resultArray addObject:str];
        
    }];
    
   return  [resultArray componentsJoinedByString:@","];
    
    

}

@end
