//
//  LaunchViewController.m
//  BaseProject
//
//  Created by Cinna on 2017/9/5.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "LaunchViewController.h"
#import "AppDelegate.h"
#import "UserInfo.h"
#import "TabBarController.h"
#import "LoginViewController.h"

@interface LaunchViewController () <UIScrollViewDelegate>

@end

@implementation LaunchViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [self showLaunchImageView];
//    [self sendRequestToGetVersion];
    [self welcomeViewFinish];
}

- (void)showLaunchImageView {
    
    CGRect frame = [UIScreen mainScreen].bounds;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = BundleImageNamed(@"Default.png");
    if (Screen_Height == 480) {
        imageView.image = BundleImageNamed(@"Default.png");
    }else if (Screen_Height == 568) {
        imageView.image = BundleImageNamed(@"Default-568h.png");
    }else if (Screen_Height == 667) {
        imageView.image = BundleImageNamed(@"Default-i6.png");
    }else if (Screen_Height == 1104) {
        imageView.image = BundleImageNamed(@"Default-plus.png");
    }else {
        imageView.image = BundleImageNamed(@"Default-X.png");
    }
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)welcomeViewFinish {
    
    LoginViewController *vc = [[LoginViewController alloc] init];
//    TabBarController *vc = [TabBarController shareInstance];
    
    AppDelegate *delegate = App_Delegate;
    delegate.window.rootViewController = vc;
}

@end
