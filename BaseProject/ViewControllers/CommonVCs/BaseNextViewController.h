//
//  BaseNextViewController.h
//  BaseProject
//
//  Created by Cinna on 2017/9/13.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseNextViewController : BaseViewController

//返回上一页面，delay时间默认0.5s
- (void)popViewControllerAfterDelay;
//推出下一个页面，delay时间默认0.5s
- (void)pushViewControllerAfterDelay:(UIViewController *)vc;

@end
