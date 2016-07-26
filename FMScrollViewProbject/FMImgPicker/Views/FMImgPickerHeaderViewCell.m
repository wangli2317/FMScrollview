//
//  FMImgPickerHeaderViewCell.m
//  mogi
//
//  Created by 王刚 on 4/5/16.
//  Copyright © 2016年 com.8w4q. All rights reserved.
//

#import "FMImgPickerHeaderViewCell.h"
#import "FMConfigure.h"

@interface FMImgPickerHeaderViewCell ()
@property (nonatomic,weak)UIImageView *backGroundView;
@end

@implementation FMImgPickerHeaderViewCell

static NSUInteger const itemWidthMargin = 3;
static NSUInteger const maxNumOfLine = 3;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backGroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"editor_photo_camera"]];
        self.backGroundView = backGroundView;
        [self addSubview:backGroundView];
    }
    return self;
}

- (void)initView:(id)object frame:(CGRect)frame{
    [super initView:object frame:frame];
    self.backGroundView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
}

+(CGFloat)calculateWidth:(id)object view:(FMScrollView *)view{
    return (SCREEN_WIDTH - (maxNumOfLine + 1) * itemWidthMargin ) / maxNumOfLine;
}

+(CGFloat)calculateHeight:(id)object view:(FMScrollView *)view{
    return (SCREEN_WIDTH - (maxNumOfLine + 1) * itemWidthMargin ) / maxNumOfLine;
}
@end
