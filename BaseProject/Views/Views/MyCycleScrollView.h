//
//  MyCycleScrollView.h
//  XTWL_XFJY
//
//  Created by xuntiangwangluo on 14-10-17.
//  Copyright (c) 2014年 xuntiangwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPageControl.h"

@protocol MyCycleScrollViewDelegate;
@protocol MyCycleScrollViewDatasource;

@interface MyCycleScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    MyPageControl *_pageControl;
    
    __unsafe_unretained id<MyCycleScrollViewDelegate> _delegate;
    __unsafe_unretained id<MyCycleScrollViewDatasource> _datasource;
    
    NSInteger _totalPages;
    NSInteger _curPage;
    
    NSMutableArray *_curViews;
}

@property (nonatomic,strong)NSTimer *scrollTimer;

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,readonly) MyPageControl *pageControl;
@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,assign)NSInteger ScrollType;//1是顶部banner，2是单张广告页，3是模块导航
@property (nonatomic,strong) NSArray *dataArray;


@property (nonatomic,assign,setter = setDataource:) id<MyCycleScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<MyCycleScrollViewDelegate> delegate;

- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;
- (void)scrollViewChangePageWithArrayCount:(int)count;
//开启定时器
- (void)myCycleScrollViewTimerStart;
//关闭定时器
- (void)myCycleScrollViewTimerEnd;

@end

@protocol MyCycleScrollViewDelegate <NSObject>

@optional
//View 的点击事件
- (void)didClickPage:(MyCycleScrollView *)csView atIndex:(NSInteger)index;

@end

@protocol MyCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages:(MyCycleScrollView *)view;
- (UIView *)myCycleScrollView:(MyCycleScrollView *)view pageAtIndex:(NSInteger)index;

@end
