//
//  TanceDetailViewController.m
//  BaseProject
//
//  Created by Cinna on 2017/11/2.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "TanceDetailViewController.h"
#import "TanceModel.h"

@interface TanceDetailViewController (){
    IBOutlet UIImageView *logoImageView;
    IBOutlet UIImageView *projectImageView;
    
    IBOutlet UILabel *biaodizhiLabel;
    IBOutlet UILabel *quyuLabel;
    IBOutlet UILabel *weizhiLabel;
    IBOutlet UILabel *xinghaoLabel;
    IBOutlet UILabel *beizhuLabel;
    IBOutlet UILabel *shebeiLabel;
    IBOutlet UILabel *xiangmuLabel;
    
    TanceModel *tanceModel;
}

@end

@implementation TanceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"探测器详情";
    self.view.backgroundColor = WHITE_COLOR;
    [self initView];
    [self sendRequestToGetData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    SetViewCorner(logoImageView, 30);
    SetViewCorner(projectImageView, 15);
    
}

- (void)setViewData {
    biaodizhiLabel.text = tanceModel.monitorInfo.monitorId;
    quyuLabel.text = tanceModel.monitorInfo.area;
    weizhiLabel.text = tanceModel.monitorInfo.location;
    xinghaoLabel.text = tanceModel.monitorInfo.type;
    beizhuLabel.text = tanceModel.monitorInfo.remark;
    shebeiLabel.text = tanceModel.monitorInfo.deviceId;
    xiangmuLabel.text = tanceModel.monitorInfo.projectName;
}

#pragma mark -
- (void)sendRequestToGetData {
    ShowProcessHud;
    WeakSelf;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.detectorBillSN  forKey:@"detectorBillSN"];
    [RequestManager sendPostRequestWithRequestName:[NSString stringWithFormat:@"http://%@/api/MonitoringDetector/GetDetectorMainInfo",UserIP] parameters:dic completeBlock:^(BOOL result, NSString *resultDesc, NSDictionary *dataDic) {
        HideProcessHud;
        tanceModel = [TanceModel mj_objectWithKeyValues:dataDic];
        [weakSelf setViewData];
        
    } failedBlock:^(NSError *error) {
        HideProcessHud
        [weakSelf showToast:ToastMsg_NetworkFailed];
    }];
}
@end
