//
//  ExchangeTypeViewController.m
//  BaseProject
//
//  Created by Cinna on 2017/9/15.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "ThirdViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface ThirdViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ThirdViewController {
    NSArray *titleArray;
    UITableView *tableView;
    
    UIImageView *logoImageView;
    UILabel *accountLabel;
    UILabel *nameLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NaviTitle_First;
    [self initSubviews];
}

- (void)initSubviews {
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Start_Height, Screen_Width, 40 * 2 + 120) style:UITableViewStylePlain];
    tableView.rowHeight = 40;
    tableView.backgroundColor = WHITE_COLOR;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"SecondCell" bundle:nil] forCellReuseIdentifier:@"SecondCell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 0;
    else if (section == 1)
        return 1;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0)
        return 100;
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
        infoView.backgroundColor = WHITE_COLOR;
        
        logoImageView = [CreateView createImageViewWithFrame:CGRectMake(SpaceLeftRight, SpaceLeftRight, 60, 60) image:ImageNamed(@"logo") superView:infoView];
        SetViewCorner(logoImageView, 30);
        accountLabel = [CreateView createLabelWithFrame:CGRectMake(logoImageView.frame.size.width + SpaceLeftRight * 2, 20, Screen_Width - logoImageView.frame.size.width - SpaceLeftRight * 3, 20) text:[UserInfo shareInstance].userAccount fontSize:FontSize_14 textColorStr:ColorText_606060 superView:infoView];
        nameLabel = [CreateView createLabelWithFrame:CGRectMake(logoImageView.frame.size.width + SpaceLeftRight * 2, 50, Screen_Width - logoImageView.frame.size.width - SpaceLeftRight * 3, 20) text:[UserInfo shareInstance].userRealName fontSize:FontSize_14 textColorStr:ColorText_606060 superView:infoView];
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, infoView.frame.size.height - 10, Screen_Width, 10)];
        view.backgroundColor = ColorWithHexString(Color_BackgroundF2F2F2);
        [infoView addSubview:view];
        return infoView;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 10)];
    view.backgroundColor = ColorWithHexString(Color_BackgroundF2F2F2);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UILabel *label = [CreateView createLabelWithFrame:CGRectMake(SpaceLeftRight, 0, Screen_Width - SpaceLeftRight * 2, 40) text:@"" fontSize:FontSize_14 textColorStr:ColorText_606060 superView:cell.contentView];
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        label.text = @"版本v1.0";
        label.textAlignment = NSTextAlignmentLeft;
        [CreateView createLineViewWithFrame:CGRectMake(0, 39.5, Screen_Width, 0.5) colorStr:ColorLine_e0e0e0 superView:cell.contentView];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        label.text = @"退出登录";
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 0) {
        
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        AppDelegate *delegate = App_Delegate;
        [UserInfo shareInstance].isAutoLogin = NO;
        [[UserInfo shareInstance] writeToDefaults];
        delegate.window.rootViewController = vc;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
