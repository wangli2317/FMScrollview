//
//  FMImgPickerTableDTO.h
//  mogi
//
//  Created by 王刚 on 6/5/16.
//  Copyright © 2016年 com.8w4q. All rights reserved.
//

#import "FMBaseDTO.h"
#import <UIKit/UIKit.h>

@interface FMImgPickerTableDTO : FMBaseDTO
@property (nonatomic , strong) UIImage  * albumImage;
@property (nonatomic , copy  ) NSString * titleString;
@property (nonatomic , copy  ) NSString * numString;
@end
