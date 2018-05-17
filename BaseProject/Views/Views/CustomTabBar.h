//
//  CustomTabBar.h
//  XTWL_XFJY
//
//  Created by xuntiangwangluo on 14-11-15.
//  Copyright (c) 2014年 xuntiangwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CusTomTabBarDelegate <NSObject>

@optional

- (void)didSelectIndex:(NSInteger)index;

@end

@interface CustomTabBar : UIView

PropertyAssign NSInteger selectIndex;

PropertyAssign id<CusTomTabBarDelegate>delegate;

+ (CustomTabBar *)sharedInstance;

- (void)setNumAtIndex:(NSInteger)index num:(long)num;

@end
