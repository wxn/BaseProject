//
//  JiankongViewController.m
//  BaseProject
//
//  Created by Cinna on 2017/11/2.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "JiankongViewController.h"
#import "TanceDetailViewController.h"
#import "JiankongListCell.h"
#import "JiankongModel.h"
#import "AFNetworking.h"
#import "JiankongItemsView.h"
#import "NetFailedView.h"

#define BaojingColor @"#F36A5A" //报警
#define ZhongduanColor @"#E5E5E5" //通讯中断，
#define ZhengchangColor @"#33b5e5" //正常
#define GuzhangColor @"#f9e491" //故障

@interface JiankongViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation JiankongViewController {
    NSMutableArray<JiankongModel *> *dataArray;
    UITableView *jiankongTable;
    NSMutableData *serverData;
    dispatch_source_t refreshTimer;
    NSMutableString *detectorIds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    dataArray = [NSMutableArray array];
    detectorIds = [NSMutableString string];
    self.navigationItem.title = @"实时监控";
    [self initSubviews];
    [self sendRequestToGetData];
}

- (void)initSubviews {
    
    jiankongTable = [[UITableView alloc] initWithFrame:CGRectMake(5, Start_Height + 5, Screen_Width - 10, Show_Height_Next - 5) style:UITableViewStylePlain];
    jiankongTable.rowHeight = 300;
    jiankongTable.backgroundColor = CLEAR_COLOR;
    jiankongTable.backgroundView = nil;
    jiankongTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    jiankongTable.estimatedSectionHeaderHeight = 0;
    jiankongTable.estimatedRowHeight = 0;
    jiankongTable.estimatedSectionFooterHeight = 0;
    [jiankongTable registerNib:[UINib nibWithNibName:@"JiankongListCell" bundle:nil] forCellReuseIdentifier:@"JiankongListCell"];
    jiankongTable.delegate = self;
    jiankongTable.dataSource = self;
    [self.view addSubview:jiankongTable];
}

- (void)setViewData {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)detailBtnClicked:(UIButton *)btn {
    JiankongModel *model = dataArray[btn.tag];
    TanceDetailViewController *vc = [[TanceDetailViewController alloc] initWithNibName:@"TanceDetailViewController" bundle:nil];
    vc.detectorBillSN = model.monitorid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)resetBtnClicked:(UIButton *)btn {
    WeakSelf;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    [alert addAction:cancle];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:AlertBtn_Confirm style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *str = alert.textFields[0].text;
        [weakSelf resetAtIndex:btn.tag psw:str];
    }];
    
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)resetAtIndex:(NSInteger)index psw:(NSString *)psw {
    
    [self sendRequestToFuweiFenzha:YES index:index psw:psw];
}

- (void)fenzhaBtnClicked:(UIButton *)btn {
    WeakSelf;
    JiankongModel *model = dataArray[btn.tag];
    if ([model.do2Value isEqualToString:@"开"]) {
        //为关时可执行分闸操作
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [alert addAction:cancle];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:AlertBtn_Confirm style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *str = alert.textFields[0].text;
            [weakSelf fenzhaAtIndex:btn.tag psw:str];
        }];
        
        [alert addAction:confirm];
        [self presentViewController:alert animated:YES completion:nil];
    }else if ([model.do2Value isEqualToString:@"关"]) {
        [self showToast:@"此时为分闸状态，不可执行分闸操作"];
    }else {
        [self showToast:@"参数缺失，无法操作"];
    }
}

- (void)fenzhaAtIndex:(NSInteger)index psw:(NSString *)psw {
    [self sendRequestToFuweiFenzha:NO index:index psw:psw];
}

- (void)createTimerToRefresh:(NSTimeInterval)time {
    WeakSelf;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    refreshTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(refreshTimer,dispatch_walltime(NULL, 0), time* NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(refreshTimer, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [weakSelf sendRequestToRefreshData];
        });
    });
    dispatch_resume(refreshTimer);
}

//logid,index
- (void)createTimerToGetOperationResponse:(NSDictionary *)dataDic {
    WeakSelf;
    NSInteger index = [dataDic[@"index"] integerValue];
    NSString *logid = dataDic[@"logid"];
    __block int timeout = 15;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _responseTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_responseTimer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_responseTimer, ^{
        if(timeout >= 1) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                if ([weakSelf getOperateResult:index]) {
                    [weakSelf sendRequestToGetFuweiFenzhaResponse:logid index:index];
                }else {
                    dispatch_source_cancel(_responseTimer);
                }
            });
            timeout --;
        }else {
            dispatch_source_cancel(_responseTimer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setOperateResult:index];
            });
        }
    });
    dispatch_resume(_responseTimer);
}

//yes代表需要继续定时
- (BOOL)getOperateResult:(NSInteger)index {
    JiankongModel *model = dataArray[index];
    if ([model.operationStr isEqualToString:@"操作执行中，请稍候..."]) {
        return YES;
    }
    return NO;
}

- (void)setOperateResult:(NSInteger)index {
    JiankongModel *model = dataArray[index];
    if (model.operationStr.length <= 0) {
        model.operationStr = @"操作失败！";
        [jiankongTable reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
    }
}

//操作失败
- (void)operationFailed:(NSInteger)index {
    JiankongModel *model = dataArray[index];
    model.operationStr = @"操作失败！";
    [jiankongTable reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
}

//操作成功
- (void)operationSuccess:(NSInteger)index {
    JiankongModel *model = dataArray[index];
    model.operationStr = @"操作成功！";
    [jiankongTable reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
}

//操作中
- (void)operationDoing:(NSInteger)index {
    JiankongModel *model = dataArray[index];
    model.operationStr = @"操作执行中，请稍候...";
    [jiankongTable reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)loadFinish {
    
    [jiankongTable reloadData];
    if (dataArray.count == 0) {
        NetFailedView *view = [[NetFailedView alloc] initNetFailedViewWithFrame:CGRectMake(0, Start_Height, Screen_Width, Show_Height_Next) title:@"没有查询到数据" reloadBlock:^{
            [dataArray removeAllObjects];
            [self sendRequestToGetData];
        }];
        [self.view addSubview:view];
    }
}

- (void)refreshDataWithArray:(NSArray *)array {
    for (NSInteger i = 0;i < array.count;i ++) {
        JiankongModel *model = dataArray[i];
        NSDictionary *newa = [self getJianKongModel:model.billSN inArray:array];
        if (!newa)
            continue;
        model.state = newa[@"state"];
        NSArray *subParam = [NSArray arrayWithArray:newa[@"paramlist"]];
        for (NSInteger j = 0;j < model.paramlist.count;j ++) {
            Paramlist *param = model.paramlist[j];
            NSDictionary *subDic = subParam[j];
            param.paramValue = subDic[@"paramValue"];
        }
    }
    [jiankongTable reloadData];
}

- (NSDictionary *)getJianKongModel:(NSString *)billSN inArray:(NSArray *)array {
    for (NSDictionary *dic in array) {
        if ([[dic objectForKey:@"billSN"] isEqualToString:billSN]) {
            return dic;
        }
    }
    return nil;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JiankongModel *model = [dataArray objectAtIndex:indexPath.section];
    float num = ceilf(model.paramlist.count/3.0);
    float height = num * 60 - 10;
    
    return 75 + height + 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JiankongListCell *cell = (JiankongListCell *)[tableView dequeueReusableCellWithIdentifier:@"JiankongListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JiankongModel *model = [dataArray objectAtIndex:indexPath.section];
    cell.operationLabel.text = model.operationStr;
    
    if ([model.operationStr isEqualToString:@"操作执行中，请稍候..."]) {
        cell.resetBtn.enabled = NO;
        cell.fenzhaBtn.enabled = NO;
    }else {
        cell.resetBtn.enabled = YES;
        cell.fenzhaBtn.enabled = YES;
    }
    
    cell.numLabel.text = model.rownum;
    cell.stateLabel.text = model.state;
    cell.quyuLabel.text = model.area;
    cell.weizhiLabel.text = model.location;
    cell.biaodizhiLabel.text = model.id;
    if ([model.state isEqualToString:@"报警"]) {
        cell.stateLabel.backgroundColor = ColorWithHexString(BaojingColor);
    }else if ([model.state isEqualToString:@"通讯中断"]) {
        cell.stateLabel.backgroundColor = ColorWithHexString(ZhongduanColor);
    }else if ([model.state isEqualToString:@"故障"]){
        cell.stateLabel.backgroundColor = ColorWithHexString(GuzhangColor);
    }else{
        cell.stateLabel.backgroundColor = ColorWithHexString(ZhengchangColor);
    }
    float num = ceilf(model.paramlist.count/3.0);
    float height = num * 60 - 10;
    
    if (!model.itemsView) {
        model.itemsView = [[JiankongItemsView alloc] initWithFrame:CGRectMake(10, 75, Screen_Width - 20, height) dataArray:model.paramlist];
    }else {
        [model.itemsView reloadData:model.paramlist];
    }
    [cell.itemsView removeFromSuperview];
    cell.itemsView = model.itemsView;
    [cell.contentView addSubview:model.itemsView];
    
    cell.bottomView.frame = CGRectMake(0, cell.itemsView.frame.origin.y +cell.itemsView.frame.size.height + 5, Screen_Width, 50);
    SetViewBorder(cell.contentView);
    
    cell.detailBtn.tag = indexPath.section;
    cell.resetBtn.tag = indexPath.section;
    cell.fenzhaBtn.tag = indexPath.section;
    
    [cell.detailBtn addTarget:self action:@selector(detailBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.resetBtn addTarget:self action:@selector(resetBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.fenzhaBtn addTarget:self action:@selector(fenzhaBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 5)];
    view.backgroundColor = ColorWithHexString(Color_BackgroundF2F2F2);
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -  
- (void)sendRequestToGetData {
    ShowProcessHud;
    WeakSelf;
    NSString *completeUrlStr = [NSString stringWithFormat:@"http://%@/api/mobile/getDetectorDataByPro?projectid=%@",UserIP,self.projectID];
    completeUrlStr = [completeUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = RequestTimeoutInterval;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [manager GET:completeUrlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HideProcessHud;
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"]\"" withString:@"]"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        for (NSInteger i = 0;i < array.count;i ++) {
            NSDictionary *newa = array[i];
            JiankongModel *model = [JiankongModel mj_objectWithKeyValues:newa];
            [detectorIds appendFormat:@"%@,",model.billSN];
            model.do2Value = [model do2ValueIn];
            [dataArray addObject:model];
        }
        [weakSelf loadFinish];
        [weakSelf sendRequestToRefreshTime];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HideProcessHud
        [weakSelf loadFinish];
    }];
}

//获取刷新时间间隔
- (void)sendRequestToRefreshTime {
    WeakSelf;
    NSString *completeUrlStr = [NSString stringWithFormat:@"http://%@/api/mobile/getRollingTime",UserIP];
    completeUrlStr = [completeUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = RequestTimeoutInterval;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [manager GET:completeUrlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HideProcessHud;
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"]\"" withString:@"]"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        NSInteger time = [dataDic[@"rollingTime"] integerValue];
        if (time > 0) {
            [weakSelf createTimerToRefresh:time];
        }else {
            [weakSelf createTimerToRefresh:2 * 60];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HideProcessHud
        [weakSelf createTimerToRefresh:2 * 60];
    }];
}

//实时数据刷新
- (void)sendRequestToRefreshData {
    WeakSelf;
    NSString *completeUrlStr = [NSString stringWithFormat:@"http://%@/api/mobile/reFreshDetectorData?detectorIds=%@",UserIP,detectorIds];
    completeUrlStr = [completeUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = RequestTimeoutInterval;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [manager GET:completeUrlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HideProcessHud;
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"]\"" withString:@"]"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        [weakSelf refreshDataWithArray:array];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HideProcessHud
    }];
}

//复位，分闸
- (void)sendRequestToFuweiFenzha:(BOOL)isFuwei index:(NSInteger)index psw:(NSString *)psw {
    WeakSelf;
    NSString *detectorbillsn = dataArray[index].billSN;
    NSString *str = [NSString stringWithFormat:@"userid=%@&ordertype=%@&detectorbillsn=%@&parameter=%@&inputpwd=%@",UserID,@"0",detectorbillsn,@"复位",psw];
    if (!isFuwei) {
        str = [NSString stringWithFormat:@"userid=%@&ordertype=%@&detectorbillsn=%@&parameter=%@&inputpwd=%@",UserID,@"0",detectorbillsn,@"分闸",psw];

    }
    [RequestManager sendGetRequestWithRequestName:[NSString stringWithFormat:@"http://%@/api/mobile/ControlOrder?%@",UserIP,str] parameters:nil completeBlock:^(BOOL result, NSString *resultDesc, NSDictionary *dataDic) {
        NSString *msg = dataDic[@"returnmsg"];
        if ([msg isEqualToString:@"验证通过"]) {
            [self operationDoing:index];
            NSDictionary *dicc = [NSDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%@",dataDic[@"logid"]],[NSNumber numberWithInteger:index]] forKeys:@[@"logid",@"index"]];
            [weakSelf performSelector:@selector(createTimerToGetOperationResponse:) withObject:dicc afterDelay:1];
        }else {
            [weakSelf showToast:@"验证失败"];
        }
    } failedBlock:^(NSError *error) {
//        [weakSelf showToast:ToastMsg_NetworkFailed];
    }];
}

//获取复位、分闸操作结果
- (void)sendRequestToGetFuweiFenzhaResponse:(NSString *)logid index:(NSInteger)index {
    WeakSelf;
    NSString *detectorbillsn = dataArray[index].billSN;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:logid  forKey:@"logid"];
    [dic setValue:detectorbillsn  forKey:@"detectorBillsn"];
    [RequestManager sendGetRequestWithRequestName:[NSString stringWithFormat:@"http://%@/api/mobile/getControlResultG",UserIP] parameters:dic completeBlock:^(BOOL result, NSString *resultDesc, NSDictionary *dataDic) {
        //注意：返回的记录中的resultState代表操作状态，0：操作执行中；1：操作失败；2：操作成功
        NSInteger state = [dataDic[@"resultState"] integerValue];
        switch (state) {
            case 0:
                [weakSelf operationDoing:index];
                break;
            case 1:
                [weakSelf operationFailed:index];
                break;
            case 2:
                [weakSelf operationSuccess:index];
                break;
            default:
                break;
        }
        
    } failedBlock:^(NSError *error) {
        
    }];
}

@end
