//
//  TabBarController.m
//  BaseProject
//
//  Created by Cinna on 2017/9/15.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "TabBarController.h"
#import "CustomTabBar.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface TabBarController ()<CusTomTabBarDelegate>

@end

@implementation TabBarController {
    
    CustomTabBar *customTabBar;
}

+(TabBarController *)shareInstance
{
    static TabBarController *controller;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        controller = [[TabBarController alloc] init];
    });
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTabBarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTabBarController
{
    FirstViewController *firstVC  = [[FirstViewController alloc] init];
    UINavigationController *firstNav  = [[UINavigationController alloc]initWithRootViewController:firstVC];

    SecondViewController *secondVC = [[SecondViewController alloc] init];
    UINavigationController *secondNav  = [[UINavigationController alloc]initWithRootViewController:secondVC];
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc]init];
    UINavigationController *thirdNav  = [[UINavigationController alloc]initWithRootViewController:thirdVC];
    
    self.viewControllers = [NSArray arrayWithObjects:firstNav, secondNav, thirdNav, nil];
    
    [self createCusTomTabBar];
    
    self.selectedIndex = 0;
}

//创建自定义tabbar
- (void)createCusTomTabBar
{
    customTabBar = [CustomTabBar sharedInstance];
    
    customTabBar.delegate = self;
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar addSubview:customTabBar];
}

#pragma mark cusTabBar delegate
- (void)didSelectIndex:(NSInteger)index {
    if (index == 3) {
//        AppDelegate *app = Get_App;
//        if (!app.curLoginStatus) {
//            
//            [self pushLoginVC];
//            
//            return;
//        }
    }
    self.selectedIndex = index;
}

- (void)setSelectedIndex:(NSUInteger)index {
//    if (selectedIndex == 3) {
//        AppDelegate *app = Get_App;
//        if (!app.curLoginStatus) {
//            return;
//        }
//    }
    
    [super setSelectedIndex:index];
    
    [CustomTabBar sharedInstance].selectIndex = index;
}

@end
