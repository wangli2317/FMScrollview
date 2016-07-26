//
//  FMImgPickerTableViewCell.m
//  mogi
//
//  Created by 王刚 on 6/5/16.
//  Copyright © 2016年 com.8w4q. All rights reserved.
//

#import "FMImgPickerTableViewCell.h"
#import "UIView+extension.h"
#import "FMImgPickerTableDTO.h"

@interface FMImgPickerTableViewCell ()
@property (nonatomic , weak) UIImageView * albumImageView;
@property (nonatomic , weak) UILabel * titleLabel;
@property (nonatomic , weak) UILabel * numLabel;
@end

@implementation FMImgPickerTableViewCell

static NSUInteger const MarginX = 8;
static NSInteger  const tableCellH = 70;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView * albumImageView = [[UIImageView alloc]init];
        self.albumImageView = albumImageView;
        [self addSubview:albumImageView];
        
        UILabel *titleLabel = [UILabel new];
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];
        
        UILabel *numLabel = [UILabel new];
        self.numLabel = numLabel;
        [self addSubview:numLabel];
        
    }
    return self;
}

-(void)setImgPickerTableDTO:(FMImgPickerTableDTO *)imgPickerTableDTO{
    _imgPickerTableDTO = imgPickerTableDTO;
    
    CGFloat albumImageViewHeight = 58;
    self.albumImageView.image = imgPickerTableDTO.albumImage;
    [self.albumImageView setContentMode:UIViewContentModeScaleAspectFill];
    self.albumImageView.frame = CGRectMake(MarginX, (tableCellH - albumImageViewHeight) * 0.5, 56, albumImageViewHeight);
    self.albumImageView.clipsToBounds = YES;
    
    self.titleLabel.text = imgPickerTableDTO.titleString;
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.albumImageView.frame)+MarginX, (tableCellH - CGRectGetHeight(self.titleLabel.frame)) * 0.5, CGRectGetWidth(self.titleLabel.frame), CGRectGetHeight(self.titleLabel.frame));
    
    self.numLabel.text = imgPickerTableDTO.numString;
    [self.numLabel sizeToFit];
    self.numLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+MarginX, (tableCellH - CGRectGetHeight(self.numLabel.frame)) * 0.5, CGRectGetWidth(self.numLabel.frame), CGRectGetHeight(self.numLabel.frame));
}

@end
