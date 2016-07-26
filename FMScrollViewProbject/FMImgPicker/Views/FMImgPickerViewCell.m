//
//  FMImgPickerViewCell.m
//  mogi
//
//  Created by 王刚 on 3/5/16.
//  Copyright © 2016年 com.8w4q. All rights reserved.
//

#import "FMImgPickerViewCell.h"
#import "FMConfigure.h"
#import "FMImgPickerDTO.h"

@interface FMImgPickerViewCell ()
@property (nonatomic , strong) UIImage * contentImg;
@property (nonatomic , assign) BOOL isChoosen;
@property (nonatomic , assign) BOOL isChoosenImgHidden;
@property (nonatomic , strong) UIImageView * mainImageView;
@property (nonatomic , strong) UIImageView * isChoosenImageView;
@end

@implementation FMImgPickerViewCell

static NSUInteger const itemWidthMargin = 3;
static NSUInteger const maxNumOfLine = 3;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *mainImageView = [[UIImageView alloc]init];
        self.mainImageView = mainImageView;
        [self addSubview:mainImageView];
        
        UIImageView *isChoosenImageView = [[UIImageView alloc]init];
        self.isChoosenImageView = isChoosenImageView;
        [self addSubview:isChoosenImageView];
    }
    return self;
}

-(void)initView:(id)object frame:(CGRect)frame{
    [super initView:object frame:frame];
    
    FMImgPickerDTO *pickDTO = self.object;
    if (pickDTO.contentImg) {
        self.mainImageView.image = pickDTO.contentImg;
        [self.mainImageView setContentMode:UIViewContentModeScaleAspectFill];
        self.mainImageView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        self.mainImageView.clipsToBounds = YES;
    }
    
    self.isChoosenImageView.hidden = pickDTO.isChoosenImgHidden;
    self.isChoosenImageView.image = [UIImage imageNamed:@"editor_photo_select"];
    [self.isChoosenImageView sizeToFit];
    self.isChoosenImageView.frame = CGRectMake(CGRectGetWidth(frame)-CGRectGetWidth(self.isChoosenImageView.frame), 0, CGRectGetWidth(self.isChoosenImageView.frame), CGRectGetHeight(self.isChoosenImageView.frame));

}

+(CGFloat)calculateWidth:(id)object view:(FMScrollView *)view{
    return (SCREEN_WIDTH - (maxNumOfLine + 1) * itemWidthMargin ) / maxNumOfLine;
}

+(CGFloat)calculateHeight:(id)object view:(FMScrollView *)view{
    return (SCREEN_WIDTH - (maxNumOfLine + 1) * itemWidthMargin ) / maxNumOfLine;
}

- (void)cellRefreshAppearWithObject:(id)object{
    FMImgPickerDTO *pickDTO = self.object;
    [UIView animateWithDuration:0.2 animations:^{
        if (pickDTO.isChoosen) {
            self.isChoosenImageView.image = [UIImage imageNamed:@"editor_photo_selected"];
        }else {
            self.isChoosenImageView.image = [UIImage imageNamed:@"editor_photo_select"];
        }
        self.isChoosenImageView.transform = CGAffineTransformMakeScale (1.1,1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.isChoosenImageView.transform = CGAffineTransformMakeScale (1.0,1.0);
        } completion:nil];
    }];
}



@end
