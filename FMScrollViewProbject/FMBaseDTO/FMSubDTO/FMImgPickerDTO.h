//
//  FMImgPickerDTO.h
//  mogi
//
//  Created by 王刚 on 3/5/16.
//  Copyright © 2016年 com.8w4q. All rights reserved.
//

#import "FMBaseDTO.h"
#import <UIKit/UIKit.h>

@class ALAsset;

@interface FMImgPickerDTO : FMBaseDTO
@property(nonatomic,strong)  UIImage *contentImg;
@property(nonatomic,assign)BOOL isChoosen;
@property(nonatomic,assign)BOOL isChoosenImgHidden;
@property(nonatomic,strong)ALAsset *result;
@end
