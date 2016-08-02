//
//  FMImgPickerTitleButtonView.m
//  mogi
//
//  Created by 王刚 on 9/5/16.
//  Copyright © 2016年 王刚. All rights reserved.
//

#import "FMImgPickerTitleButtonView.h"
#import "FMConfigure.h"

@interface FMImgPickerTitleButtonView ()
@property (nonatomic,weak) UILabel *titleLabel;
@end

@implementation FMImgPickerTitleButtonView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel         = [UILabel new];
        [self addSubview:titleLabel];
        titleLabel.textColor        = [UIColor blackColor];
        titleLabel.textAlignment    = NSTextAlignmentCenter;
        titleLabel.font             = [UIFont boldSystemFontOfSize:16];
        self.titleLabel             = titleLabel;

        UIImageView *imageView      = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"editor_photo_dropdown"]];
        [self addSubview:imageView];
        [imageView sizeToFit];
        self.imageView              = imageView;

        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setTitleString:(NSString *)titleString{
    _titleString         = titleString;
    self.titleLabel.text = titleString;
    [self.titleLabel sizeToFit];

    self.imageView.fm_layout.rightEqualToView(self).centerYEqualToView(self).heightIs(CGRectGetHeight(self.imageView.frame)).widthIs(CGRectGetWidth(self.imageView.frame));
    self.titleLabel.fm_layout.leftEqualToView(self).rightSpaceToView(self.imageView,3).centerYEqualToView(self).heightIs(CGRectGetHeight(self.titleLabel.frame));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(touchButtonView:)]) {
        [self.delegate touchButtonView:self];
    }
}

@end
