//
//  SecondViewController.m
//  BaseProject
//
//  Created by Cinna on 2017/9/15.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondCell.h"
#import "BaojingModel.h"
#import "NetFailedView.h"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SecondViewController {
    NSMutableArray *dataArray;
    UITableView *tableView;
    NSInteger page;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    page = 1;
    [self sendRequestToGetData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self hideProcessHud];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NaviTitle_First;
    dataArray = [NSMutableArray array];
//    page = 1;
    [self initSubviews];
//    [self sendRequestToGetData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubviews {
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Start_Height, Screen_Width, Show_Height) style:UITableViewStylePlain];
    tableView.rowHeight = 160;
    tableView.estimatedRowHeight = 160;
    tableView.backgroundColor = WHITE_COLOR;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"SecondCell" bundle:nil] forCellReuseIdentifier:@"SecondCell"];
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

#pragma mark - 刷新
-(void)pullTableViewToRefresh {
    page = 1;
    [self sendRequestToGetData];
}

-(void)pullTableViewToLoadMore {
    [self sendRequestToGetData];
}

-(void)finishRefresh:(BOOL)isShowMore {
    [tableView reloadData];
    [tableView.mj_header endRefreshing];
    if (isShowMore)
        [tableView.mj_footer endRefreshing];
    else
        [tableView.mj_footer endRefreshingWithNoMoreData];
    if (dataArray.count == 0) {
        NetFailedView *view = [[NetFailedView alloc] initNetFailedViewWithFrame:CGRectMake(0, Start_Height, Screen_Width, Show_Height) title:@"没有查询到数据" reloadBlock:^{
            [dataArray removeAllObjects];
            page = 1;
            [self sendRequestToGetData];
        }];
        [self.view addSubview:view];
    }
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondCell *cell = (SecondCell *)[tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BaojingModel *model = dataArray[indexPath.row];
    cell.numLabel.text = model.Num;
    cell.nameLabel.text = model.Remark;
    cell.dateLabel.text = model.Createtime;
    
    cell.xiangmuLabel.text = model.ProjectName;
    cell.deviceNoLabel.text = model.Deviceid;
    cell.tongdaoLabel.text = model.ID;
    cell.weizhiLabel.text = model.Address.length>0?model.Address:@"未知";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
- (void)sendRequestToGetData {
//    ShowProcessHud;
    WeakSelf;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:UserID  forKey:@"userid"];
    [dic setValue:@"15"  forKey:@"pagesize"];
    [dic setValue:[NSNumber numberWithInteger:page]  forKey:@"page"];
    [RequestManager sendPostRequestWithRequestName:[NSString stringWithFormat:@"http://%@/api/mobile/GetAlarmData",UserIP] parameters:dic completeBlock:^(BOOL result, NSString *resultDesc, NSDictionary *dataDic) {
        HideProcessHud;
        if (page == 1) {
            [dataArray removeAllObjects];
        }
        if ([dataDic isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)dataDic;
            for (NSInteger i = 0;i < arr.count;i ++) {
                NSDictionary *dic = arr[i];
                BaojingModel *model = [BaojingModel mj_objectWithKeyValues:dic];
                [dataArray addObject:model];
            }
            page ++;
            if (arr.count >= 15)
                [weakSelf finishRefresh:YES];
            else
                [weakSelf finishRefresh:NO];
        }else if ([dataDic isKindOfClass:[NSDictionary class]]) {
            BaojingModel *model = [BaojingModel mj_objectWithKeyValues:dataDic];
            [dataArray addObject:model];
            page ++;
            [weakSelf finishRefresh:NO];
            
        }else {
            [weakSelf finishRefresh:NO];
        }
    } failedBlock:^(NSError *error) {
        HideProcessHud
        [weakSelf showToast:ToastMsg_NetworkFailed];
        [weakSelf finishRefresh:NO];
    }];
}
@end
