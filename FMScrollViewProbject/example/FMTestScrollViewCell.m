//
//  FMTestScrollViewCell.m
//  mogi
//
//  Created by cherry on 15/12/17.
//  Copyright © 2015年 com.8w4q. All rights reserved.
//

#import "FMTestScrollViewCell.h"
#import "FMConfigure.h"
#import "UIView+extension.h"
#import "FMScrollView.h"
#import "NSString+Utils.h"
#import "FMTestScrollViewDTO.h"

@implementation FMTestScrollViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.contentMode = UIViewContentModeRedraw;
        
        
        self.textContent = [[UILabel alloc] initWithFrame:CGRectZero];
        self.textContent.font = SYS_FONT(12.0);
        self.textContent.textColor = [UIColor colorWithRed:93/255.0 green:93/255.0 blue:93/255.0 alpha:1];
        self.textContent.textAlignment = NSTextAlignmentLeft;
        self.textContent.numberOfLines = 0;
        
        [self addSubview:self.textContent];
    }
    return self;
}


- (void)prepareForReuse{
    [super prepareForReuse];
    self.layer.shadowPath = nil;
    self.textContent.text = nil;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void) cellAppear{
    //set image here
    
    
}

- (void)initView:(id)object frame:(CGRect)frame{
    [super initView:object frame:frame];
    
    FMTestScrollViewDTO *exPanDTO = self.object;
    //NSLog(@"Frame x=%f y=%f w=%f h=%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    NSInteger cx = 5;
    NSInteger cwidth = self.width-10;
    self.textContent.text = exPanDTO.content;
    CGSize size = [exPanDTO.content sizeWithFont:SYS_FONT(12.0) boundingRect:CGSizeMake(cwidth, 600)];
    self.textContent.frame = CGRectMake(cx, 0, cwidth, size.height+10);

}
+ (CGFloat)calculateHeight:(id)object view:(FMScrollView*)view{
    
    FMTestScrollViewDTO *exPanDTO = object;
    CGFloat width = [FMTestScrollViewCell calculateWidth:object view:view];
    CGSize size = [exPanDTO.content sizeWithFont:SYS_FONT(12.0) boundingRect:CGSizeMake(width-10, 600)];
    return size.height+10;
    //return 300;
}

+ (CGFloat)calculateWidth:(id)object view:(FMScrollView*)view{

    return (view.width-3*view.cellMarginLeft)/2;
}

@end
