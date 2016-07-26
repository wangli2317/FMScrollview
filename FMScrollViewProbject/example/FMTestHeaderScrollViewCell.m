//
//  FMTestHeaderScrollViewCell.m
//  mogi
//
//  Created by cherry on 15/12/17.
//  Copyright © 2015年 com.8w4q. All rights reserved.
//

#import "FMTestHeaderScrollViewCell.h"
#import "FMConfigure.h"
#import "UIView+extension.h"
#import "FMScrollView.h"
#import "NSString+Utils.h"
#import "FMTestHeaderDTO.h"

@implementation FMTestHeaderScrollViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor colorWithRed:247/255.0 green:248/255.0 blue:237/255.0 alpha:1];
        self.contentMode = UIViewContentModeRedraw;
        
        
        self.textContent = [[UILabel alloc] initWithFrame:CGRectZero];
        self.textContent.font = SYS_FONT(12.0);
        self.textContent.textColor = [UIColor colorWithRed:93/255.0 green:93/255.0 blue:93/255.0 alpha:1];
        //self.textContent.backgroundColor = [UIColor clearColor];
        self.textContent.textAlignment = NSTextAlignmentLeft;
        self.textContent.numberOfLines = 0;
        
        [self addSubview:self.textContent];
    }
    return self;
}


- (void)prepareForReuse{
    [super prepareForReuse];
    self.layer.shadowPath = nil;
    //[self.textView setHidden:YES];
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
    
    FMTestHeaderDTO *HeaderDTO = self.object;
    //NSLog(@"Frame x=%f y=%f w=%f h=%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    NSInteger cx = 5;
    NSInteger cwidth = self.width-10;
    self.textContent.text = HeaderDTO.content;
    CGSize size = [HeaderDTO.content sizeWithFont:SYS_FONT(12.0) boundingRect:CGSizeMake(cwidth, 600)];
    self.textContent.frame = CGRectMake(cx, 0, cwidth, size.height+10);
    
}
+ (CGFloat)calculateHeight:(id)object view:(FMScrollView*)view{
    
    FMTestHeaderDTO *HeaderDTO = object;
    CGFloat width = [FMTestHeaderScrollViewCell calculateWidth:object view:view];
    CGSize size = [HeaderDTO.content sizeWithFont:SYS_FONT(12.0) boundingRect:CGSizeMake(width-10, 600)];
    return size.height+10;
    //return 300;
}

+ (CGFloat)calculateWidth:(id)object view:(FMScrollView*)view{
    //NSLog(@"View Width=%f",view.width);
    
    return (view.width-2*view.cellMarginLeft);
    
    //return (view.width-3*view.columnWidth)/2;
    //return view.columnWidth*(floorf((view.numCols-3)/2));
}

+ (BOOL)fixedCell{
    return YES;
}

@end
