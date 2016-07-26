//
//  FMDataManager.h
//  mogi
//
//  Created by cherry on 15/8/12.
//  Copyright (c) 2015年 com.8w4q. All rights reserved.
//


// Frameworks
#import <Foundation/Foundation.h>
#import "FMConfigure.h"

@interface FMDataManager : NSObject

+ (FMDataManager *)sharedFMDataManger;

#pragma mark - DataManager for FMScrollViewManager
- (void)fetchDataFromServerWithDataMethod:(NSString *)dataMethod page:(NSInteger)page otherParams:(NSMutableDictionary *)otherParams success:(void (^)(id data))success failed:(void (^)(NSString * message)) failed;


@end
