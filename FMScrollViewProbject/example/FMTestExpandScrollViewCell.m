//
//  FMTestExpandScrollViewCell.m
//  mogi
//
//  Created by cherry on 15/12/20.
//  Copyright © 2015年 com.8w4q. All rights reserved.
//

#import "FMTestExpandScrollViewCell.h"
#import "FMConfigure.h"
#import "UIView+extension.h"
#import "FMScrollView.h"
#import "NSString+Utils.h"
#import "FMTestExpandDTO.h"

@implementation FMTestExpandScrollViewCell
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
        //self.textContent.backgroundColor = [UIColor clearColor];
        self.textContent.textAlignment = NSTextAlignmentLeft;
        self.textContent.numberOfLines = 0;
        
        [self addSubview:self.textContent];
        
        self.expand = [[UIButton alloc] initWithFrame:CGRectMake(50, 5, 55, 15)];
        [self.expand setBackgroundColor:[UIColor colorWithRed:252/255.0 green:186/255.0 blue:40/255.0 alpha:.9]];
        [self.expand setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.expand.titleLabel.font = SYS_FONT(12.0);
        [self.expand setTitle:@"Expand" forState:UIControlStateNormal];
        self.expand.tag = FMExpandButtonTypeExpand;
        
        [self.expand addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.deleteBtn setBackgroundColor:[UIColor redColor]];
        [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.deleteBtn.titleLabel.font = SYS_FONT(12.0);
        [self.deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
        self.deleteBtn.tag = FMExpandButtonTypeDelete;
        
        [self.deleteBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.expand];
        [self addSubview:self.deleteBtn];
    }
    return self;
}


- (void)prepareForReuse{
    [super prepareForReuse];
    self.layer.shadowPath = nil;
    //[self.textView setHidden:YES];
    self.textContent.text = nil;
    self.deleteBtn.frame = CGRectZero;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void) cellAppear{
    //set image here
    
    
}

- (void)initView:(id)object frame:(CGRect)frame{
    [super initView:object frame:frame];
    
    FMTestExpandDTO *DTO = self.object;
    //NSLog(@"Frame x=%f y=%f w=%f h=%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    NSInteger cx = 5;
    NSInteger cwidth = self.width-10;
    self.textContent.text = DTO.content;
    CGSize size = [DTO.content sizeWithFont:SYS_FONT(12.0) boundingRect:CGSizeMake(cwidth, 600)];
    self.textContent.frame = CGRectMake(cx, 0, cwidth, size.height+10);
    
    self.expand.frame = CGRectMake(cwidth-60, 5, 55, 15);
    
    
    self.canBeMovedToLeft = YES;
    self.canBeMovedToLeftWidth = 100;
    self.deleteBtn.frame = CGRectMake(frame.size.width, 0, 0, frame.size.height);
}


- (void)clickButton:(id)sender{
    FMScrollView* superView = (FMScrollView*) self.superview;
    if (superView.vdelegate && [superView.vdelegate respondsToSelector:@selector(buttonClicked:cell:)]) {
        [superView.vdelegate buttonClicked:sender cell:self];
    }
}

- (void)movedToLeftViewWithOffsetX:(CGFloat)x orgFrame:(CGRect)orgFrame{
    if(x==0){
        self.frame = orgFrame;
    }else{
        self.x = orgFrame.origin.x-x;
        self.width = orgFrame.size.width+x;
    }
    self.deleteBtn.frame = CGRectMake(orgFrame.size.width, 0, x, self.height);
}

+ (CGFloat)calculateHeight:(id)object view:(FMScrollView*)view{
    
    FMTestExpandDTO *DTO = object;
    CGFloat width = [FMTestExpandScrollViewCell calculateWidth:object view:view];
    CGSize size = [DTO.content sizeWithFont:SYS_FONT(12.0) boundingRect:CGSizeMake(width-10, 600)];
    return size.height+10;
    //return 300;
}

+ (CGFloat)calculateWidth:(id)object view:(FMScrollView*)view{
    // one column
    return (view.width-2*view.cellMarginLeft);
}

@end
