//
//  ScrollListView.m
//  ScrollViewList
//
//  Created by WXN on 14-4-28.
//  Copyright (c) 2014年 WXN. All rights reserved.
//

#import "ScrollListView.h"

@implementation ScrollListView
{
//    float horizontalborderSpace;//左右边界的间隙
//    float verticalborderSpace;//左右边界的间隙
//    float horizontalCellSpace;//左右边界的间隙
//    float verticalCellSpace;//左右边界的间隙
    
    int horizontalNumber;
    int totalNumber;
    CGSize size;
    float space;
}

- (id)initWithFrame:(CGRect)frame cellSize:(CGSize)cellSize withDelegate:(id<ScrollListDelegate,UIScrollViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        size = cellSize;
        self.delegate = delegate;
        [self initScrollListView];
    }
    return self;
}

-(void)initScrollListView
{
    [self setHorizontalNumber];
    [self setTotalNumber];
    for(int i=0;i<totalNumber;i++)
    {
        int numX = i % horizontalNumber;
        int numY = i / horizontalNumber;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:numX inSection:numY];
        UIView *cell = [self.delegate scrollListView:self cellForRowAtIndexPath:indexPath];
        cell.tag = i;
        
        float X = numX * (size.width + self.horizontalCellSpace) + self.horizontalborderSpace;
        float Y = numY * (size.height + self.verticalCellSpace) +self.verticalborderSpace;
        cell.frame = CGRectMake(X, Y, size.width,size.height);
        [self addGestureRecoginzer:cell];
        [self addSubview:cell];
    }
}

#pragma mark 获取每行个数及总数
-(void)setHorizontalNumber
{
    horizontalNumber = [self.delegate horizontalNumberOfScrollListView:self];
    space = (self.frame.size.width - horizontalNumber*size.width) / (horizontalNumber + 1); //设置默认空隙
    self.horizontalborderSpace = self.horizontalCellSpace = self.verticalborderSpace = self.verticalCellSpace = space;
}

-(void)setTotalNumber
{
    totalNumber = [self.delegate totalNumberOfScrollListView:self];
    int num = (totalNumber + horizontalNumber - 1)/ horizontalNumber;
    self.contentSize = CGSizeMake(320,num * (size.height + space) +space);
}

#pragma mark 手势相关
-(void)addGestureRecoginzer:(UIView *)view
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleGesture:)];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    [view addGestureRecognizer:longPress];
    [view addGestureRecognizer:singleTap];
    //在长按手势识别失败后识别单击手势
    [singleTap requireGestureRecognizerToFail:longPress];
}

-(void)singleGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    int numX = gestureRecognizer.view.tag % horizontalNumber;
    int numY = gestureRecognizer.view.tag / horizontalNumber;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:numX inSection:numY];
    if([self.delegate respondsToSelector:@selector(scrollListView:tapCell:indexPath:)])
    {
        [self.delegate scrollListView:self tapCell:gestureRecognizer.view indexPath:indexPath];
    }
}

-(void)longPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    int numX = gestureRecognizer.view.tag % horizontalNumber;
    int numY = gestureRecognizer.view.tag / horizontalNumber;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:numX inSection:numY];
    if([self.delegate respondsToSelector:@selector(scrollListView:pressCell:indexPath:)])
    {
        [self.delegate scrollListView:self pressCell:gestureRecognizer.view indexPath:indexPath];
    }
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
