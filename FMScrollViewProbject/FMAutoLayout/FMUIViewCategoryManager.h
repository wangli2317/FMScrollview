//
//  FMUIViewCategoryManager.h
//  GSD_WeiXin(wechat)
//
//  Created by 王刚 on 6/4/16.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMUIViewCategoryManager : NSObject

@property (nonatomic, strong) NSArray *rightViewsArray;
@property (nonatomic, assign) CGFloat rightViewRightMargin;

@property (nonatomic, weak) UITableView *fm_tableView;
@property (nonatomic, strong) NSIndexPath *fm_indexPath;
@end
