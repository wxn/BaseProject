//
//  FirstViewController.m
//  BaseProject
//
//  Created by Cinna on 2017/9/15.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "FirstViewController.h"
#import "HomeCell.h"
#import "ProjectDetailViewController.h"
#import "JiankongViewController.h"
#import "ProjectModel.h"
#import "NetFailedView.h"

@interface FirstViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@end

@implementation FirstViewController {
    NSMutableArray *dataArray;
    UITableView *tableView;
    NSInteger page;
    UISearchBar *searchBar;
    NetFailedView *netFailedView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NaviTitle_First;
    [self initSubviews];
    page = 1;
    dataArray = [NSMutableArray array];
    [self initSearchRightBtn];
    
    [self sendRequestToGetData:searchBar.text];
}

- (void)initSearchRightBtn {
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:ImageNamed(@"search") style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnClicked)];
    self.navigationItem.rightBarButtonItem = btn;
}

- (void)initCloseRightBtn {
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:ImageNamed(@"remove") style:UIBarButtonItemStylePlain target:self action:@selector(closeSearchBtnClicked)];
    self.navigationItem.rightBarButtonItem = btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showSearchBar {
//    if (!searchBar) {
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
    searchBar.delegate = self;
//    [searchBar setTintColor:WHITE_COLOR];
        searchBar.placeholder = @"输入项目名称/客户/地址";
//        UIImage* clearImg = [self imageWithColor:[UIColor clearColor] andHeight:32.0f];
//        [searchBar setBackgroundImage:clearImg];
//        [searchBar setSearchFieldBackgroundImage:clearImg forState:UIControlStateNormal];
//        [searchBar setBackgroundColor:[UIColor clearColor]];
//        [[[searchBar.subviews objectAtIndex:0].subviews objectAtIndex:1] setTintColor:[UIColor greenColor]];
        UITextField *searchField = [searchBar valueForKey:@"_searchField"];
        searchField.enablesReturnKeyAutomatically = NO;
//        searchField.textColor = ColorWithHexString(ColorText_333333);
//        searchField.placeholder = @"输入项目名称/客户/地址";
//        [searchField setTintColor:BLACK_COLOR];
//        [searchField setValue:ColorWithHexString(ColorText_333333) forKeyPath:@"_placeholderLabel.textColor"];
//    }
    self.navigationItem.titleView = searchBar;
    [searchBar becomeFirstResponder];
    [self initCloseRightBtn];
}

- (UIImage*) imageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)hideSearchBar {
    self.navigationItem.titleView = nil;
    [self initSearchRightBtn];
}

- (void)initSubviews {
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Start_Height, Screen_Width, Show_Height) style:UITableViewStylePlain];
    tableView.rowHeight = 145;
    tableView.estimatedRowHeight = 145;
    tableView.backgroundColor = WHITE_COLOR;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    WeakSelf;
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf pullTableViewToLoadMore];
    }];
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf pullTableViewToRefresh];
    }];
}

#pragma mark -
- (void)searchBtnClicked {
    [self showSearchBar];
}

- (void)closeSearchBtnClicked {
    [self hideSearchBar];
}

- (void)detailBtnClicked:(UIButton *)btn {
    ProjectDetailViewController *vc = [[ProjectDetailViewController alloc] initWithNibName:@"ProjectDetailViewController" bundle:nil];
    ProjectModel *model = dataArray[btn.tag];
    vc.projectID = model.projectID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jiankongBtnClicked:(UIButton *)btn {
    JiankongViewController *vc = [[JiankongViewController alloc] init];
    ProjectModel *model = dataArray[btn.tag];
    vc.projectID = model.projectID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    page = 1;
    [self sendRequestToGetData:searchBar.text];
}

#pragma mark - 刷新
-(void)pullTableViewToRefresh {
    page = 1;
    [self sendRequestToGetData:searchBar.text];
}

-(void)pullTableViewToLoadMore {
    [self sendRequestToGetData:searchBar.text];
}

-(void)finishRefresh:(BOOL)isShowMore {
    [tableView reloadData];
    [tableView.mj_header endRefreshing];
    if (isShowMore)
        [tableView.mj_footer endRefreshing];
    else
        [tableView.mj_footer endRefreshingWithNoMoreData];
    if (dataArray.count == 0) {
        netFailedView = [[NetFailedView alloc] initNetFailedViewWithFrame:CGRectMake(0, Start_Height, Screen_Width, Show_Height) title:@"没有查询到数据" reloadBlock:^{
            [dataArray removeAllObjects];
            page = 1;
            [self sendRequestToGetData:searchBar.text];
        }];
        [self.view addSubview:netFailedView];
    }
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.detailBtn addTarget:self action:@selector(detailBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.jiankongBtn addTarget:self action:@selector(jiankongBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.detailBtn.tag = indexPath.row;
    cell.jiankongBtn.tag = indexPath.row;
    ProjectModel *model = dataArray[indexPath.row];
    cell.numLabel.text = model.rownum;
    cell.nameLabel.text = model.projectName;
    cell.kehuLabel.text = model.customerName;
    cell.addressLabel.text = model.address;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
- (void)sendRequestToGetData:(NSString *)searchText {
    ShowProcessHud;
    WeakSelf;
    if (netFailedView) {
        [netFailedView removeFromSuperview];
    }
    NSString *str = [NSString stringWithFormat:@"userid=%@&pagesize=15&page=%ld",UserID,(long)page];
    if (searchText) {
        str = [NSString stringWithFormat:@"userid=%@&condition=%@&pagesize=15&page=%ld",UserID,searchText,(long)page];
    }
    [RequestManager sendGetRequestWithRequestName:[NSString stringWithFormat:@"http://%@/api/mobile/GetProjects?%@",UserIP,str] parameters:nil completeBlock:^(BOOL result, NSString *resultDesc, NSDictionary *dataDic) {
         HideProcessHud;
         if (result) {
             if (page == 1) {
                 [dataArray removeAllObjects];
             }
             NSArray *arr = dataDic[@"datalist"];
             for (NSInteger i = 0;i < arr.count;i ++) {
                 NSDictionary *dic = arr[i];
                 ProjectModel *model = [ProjectModel mj_objectWithKeyValues:dic];
                 [dataArray addObject:model];
             }
             if (arr.count >= 15) {
                 [weakSelf finishRefresh:YES];
                 page ++;
             }else
                 [weakSelf finishRefresh:NO];
         }else {
             [weakSelf showToast:@"请求失败"];
             [weakSelf finishRefresh:YES];
         }
     } failedBlock:^(NSError *error) {
         HideProcessHud
         [weakSelf finishRefresh:YES];
     }];
}

@end
