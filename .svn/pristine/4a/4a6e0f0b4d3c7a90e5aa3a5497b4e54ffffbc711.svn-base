//
//  MyPageControl.m
//  HealthPilot
//
//  Created by quanwangwulian on 14-4-10.
//  Copyright (c) 2014年 quanwangwulian. All rights reserved.
//

#import "MyPageControl.h"

@implementation MyPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

    }
    return self;
}

- (void)updateDots
{
    for(int i = 0; i< [self.subviews count]; i++)
    {
        UIImageView *doc = [self.subviews objectAtIndex:i];
    
            if(i == self.currentPage)
            {
                doc.backgroundColor = [UIColor colorWithHexString:Color_MainFFDA44];
            }
            else
            {
                doc.backgroundColor = [UIColor colorWithHexString:@"#929292"];
            }
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    
    [self updateDots];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
