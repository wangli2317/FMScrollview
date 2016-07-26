//
//  FMTestExpandScrollViewCell.h
//  mogi
//
//  Created by cherry on 15/12/20.
//  Copyright © 2015年 com.8w4q. All rights reserved.
//

#import "FMScrollViewCell.h"


//定义Button类型
typedef NS_ENUM(NSInteger, FMExpandButtonType) {
    /**删除按钮*/
    FMExpandButtonTypeDelete = 1,
    /**展开按钮*/
    FMExpandButtonTypeExpand = 2,
};

@interface FMTestExpandScrollViewCell : FMScrollViewCell

@property (nonatomic, strong) UILabel *textContent;
@property (nonatomic, strong) UIButton *expand;
@property (nonatomic, strong) UIButton *deleteBtn;

@end
