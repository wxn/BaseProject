//
//  SettingViewController.m
//  BaseProject
//
//  Created by Cinna on 2017/10/25.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SettingViewController {
    NSArray *titleArray;
    UITableView *tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubviews];
}

- (void)initSubviews {
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Start_Height, Screen_Width, titleArray.count * 48) style:UITableViewStylePlain];
    tableView.rowHeight = 48;
    tableView.backgroundColor = WHITE_COLOR;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.font = Font14;
    cell.textLabel.textColor = ColorWithHexString(ColorText_333333);
    cell.textLabel.text = titleArray[indexPath.row];
    [CreateView createLineViewWithFrame:CGRectMake(SpaceLeftRight, 47.5, Screen_Width - SpaceLeftRight, 0.5) colorStr:ColorLine_ededed superView:cell.contentView];
    
    [CreateView createLineViewWithFrame:CGRectMake(SpaceLeftRight, 0, Screen_Width - SpaceLeftRight, 0.5) colorStr:ColorLine_ededed superView:cell.contentView];
    
    UILabel *rightLabel = [CreateView createLabelWithFrame:CGRectMake(Screen_Width - 30 - 100, 14, 100, 20) text:@"" fontSize:FontSize_14 textColorStr:ColorText_999999 superView:cell.contentView];
    rightLabel.textAlignment = NSTextAlignmentRight;
    
    switch (indexPath.row) {
        case 0: {
            UIImageView *headImageView = [CreateView createImageViewWithFrame:CGRectMake(Screen_Width - 30 - 30, 9, 30, 30) image:nil superView:cell.contentView];
            [headImageView sd_setImageWithURLStr:@"" placeholderImage:ImageWithContentFile(@"h_pic")];
            SetViewCorner(headImageView, 15);
            rightLabel.text = @"";
            break;
        }
        case 1:
            rightLabel.text = @"";
            break;
        case 2:
            rightLabel.text = @"";
            break;
        case 3:
            rightLabel.text = @"";
            break;
        case 4:
            rightLabel.text = @"";
            break;
        case 5:
            rightLabel.text = [NSString stringWithFormat:@"v%@",App_Version];
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            return;
        case 1:
            return;
        case 2:
            return;
        case 3:
            return;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
