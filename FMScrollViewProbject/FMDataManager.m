//
//  FMDataManager.m
//  mogi
//
//  Created by cherry on 15/8/12.
//  Copyright (c) 2015年 com.8w4q. All rights reserved.
//

//Frameworks
#import "FMDataManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "NSDictionary+Utils.h"
#import "FMImgPickerDTO.h"
#import "FMTestScrollViewDTO.h"
#import "FMTestExpandDTO.h"

@implementation FMDataManager

/*全局访问入口*/
+ (FMDataManager *)sharedFMDataManger{
    static FMDataManager *dataManger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManger = [[self alloc]init];
    });
    return dataManger;
}

#pragma mark - DataManager for FMScrollViewManager
- (void)fetchDataFromServerWithDataMethod:(NSString *)dataMethod page:(NSInteger)page otherParams:(NSMutableDictionary *)otherParams success:(void (^)(id data))success failed:(void (^)(NSString * message)) failed{
    
    SEL aSelector = NSSelectorFromString(dataMethod);
    
    if([self respondsToSelector:aSelector]) {
        
        NSLog(@"fetchDataFromServerWithDataMethod success :%@",dataMethod);
        
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:aSelector]];
        [inv setSelector:aSelector];
        [inv setTarget:self];
        
        [inv setArgument:&(page) atIndex:2]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
        [inv setArgument:&(otherParams) atIndex:3];
        [inv setArgument:&(success) atIndex:4]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
        [inv setArgument:&(failed) atIndex:5]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
        
        [inv invoke];
    }else{
        NSLog(@"fetchDataFromServerWithDataMethod failed :%@",dataMethod);
    }
}

- (void) fetchImgPickerDataByPage:(NSInteger)page otherParams:(NSMutableDictionary *)otherParams success:(void (^)(id data))success failed:(void (^)(NSString * message)) failed{
    
    ALAssetsGroup *group = [otherParams objectAtKey:@"group"];
    BOOL hiddenChoosenImage = [[otherParams objectForKey:@"hiddenChoosenImage"] boolValue];
    
    NSMutableArray *originImgData = [NSMutableArray array];
    CGFloat pageDataNumber = 40;
    NSInteger pageRange = (page-1)*pageDataNumber;
    
    NSInteger groupCount = group.numberOfAssets;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            @autoreleasepool {
                if (pageRange < groupCount &&  index >  groupCount - pageRange - pageDataNumber  && index <= groupCount - pageRange && result) {
                    NSString *type=[result valueForProperty:ALAssetPropertyType];
                    if ([type isEqualToString:ALAssetTypePhoto]) {
                        FMImgPickerDTO *imgPickerDTO = [FMImgPickerDTO new];
                        if (ios9x) {
                            imgPickerDTO.contentImg =  [UIImage imageWithCGImage:result.aspectRatioThumbnail];
                        }else{
                            imgPickerDTO.contentImg =  [UIImage imageWithCGImage:result.thumbnail];
                        }
                        imgPickerDTO.isChoosenImgHidden = hiddenChoosenImage;
                        imgPickerDTO.isChoosen = NO;
                        imgPickerDTO.result = result;
                        
                        [originImgData addObject:imgPickerDTO];
                    }
                }
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (originImgData&&originImgData.count>0) {
                if (success) {
                    success(originImgData);
                }
            }else{
                if (failed) {
                    failed(@"false");
                }
            }
        });
    });
}

- (void) fetchTestDataByPage:(NSInteger)page otherParams:(NSMutableDictionary *)otherParams success:(void (^)(id data))success failed:(void (^)(NSString * message)) failed{
    FMTestScrollViewDTO *testScrollDTO = [FMTestScrollViewDTO new];
    testScrollDTO.content = @"乐哈哈";
    
    FMTestExpandDTO *expandDTO = [FMTestExpandDTO new];
    expandDTO.content = @"别呀";
    expandDTO.FM_CLASSTYPE = @"FMTestExpandScrollViewCell";
    
    if (success) {
        success([NSArray arrayWithObjects:testScrollDTO,testScrollDTO,expandDTO,expandDTO,testScrollDTO,expandDTO ,nil]);
    }
}
@end

