//
//  BaseViewController.h
//  BaseProject
//
//  Created by Cinna on 2017/9/13.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

#pragma mark - 提示框相关
//显示提示信息
-(void)showToast:(NSString *)text;

//在window上显示提示信息
- (void)showToastInWindow:(NSString *)text;

//显示进度提示框
-(void)showProcessHud;

//隐藏进度提示框
-(void)hideProcessHud;

//在window上显示进度提示框
- (void)showProcessHudInWindow;

//隐藏window进度提示框
- (void)hideProcessHudInWindow;

//设置导航条的底部的线是否显示，默认显示
- (void)setNavigationBarLineVisiable:(BOOL)isVisiable;

@end
