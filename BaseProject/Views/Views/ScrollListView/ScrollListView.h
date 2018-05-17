//
//  ScrollListView.h
//  ScrollViewList
//
//  Created by WXN on 14-4-28.
//  Copyright (c) 2014年 WXN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollListDelegate;

@interface ScrollListView : UIScrollView

@property(nonatomic,assign)id<ScrollListDelegate,UIScrollViewDelegate>delegate;

//不设置为默认值
@property(nonatomic,assign)float horizontalborderSpace;//左右边界的间隙
@property(nonatomic,assign)float verticalborderSpace;//上下边界的间隙
@property(nonatomic,assign)float horizontalCellSpace; //cell横向的间隙
@property(nonatomic,assign)float verticalCellSpace; //cell纵向的间隙

//初始化scrollListView，需传入cell的size和delegate
- (id)initWithFrame:(CGRect)frame cellSize:(CGSize)cellSize withDelegate:(id<ScrollListDelegate,UIScrollViewDelegate>)delegate;

@end
    
@protocol ScrollListDelegate <NSObject>
    
@required
//每个cell的定义
-(UIView *)scrollListView:(ScrollListView *)scrollList cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//返回每行的cell个数
-(NSInteger)horizontalNumberOfScrollListView:(ScrollListView *)tableView;

//返回cell的总数
-(NSInteger)totalNumberOfScrollListView:(ScrollListView *)tableView;
        
@optional
//单击cell
-(void)scrollListView:(ScrollListView *)scrollList tapCell:(UIView *)cell indexPath:(NSIndexPath *)indexPath;

//长按cell
-(void)scrollListView:(ScrollListView *)scrollList pressCell:(UIView *)cell indexPath:(NSIndexPath *)indexPath;

//定义cell的间隙，上下及左右,不设置为平均
//-(float)scrollListView:(ScrollListView *)scrollList horizontalSpace:(float)horizontalSpace verticalSpace:(float)verticalSpace;

@end
