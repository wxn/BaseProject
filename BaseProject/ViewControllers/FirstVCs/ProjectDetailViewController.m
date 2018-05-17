//
//  ProjectDetailViewController.m
//  BaseProject
//
//  Created by Cinna on 2017/11/2.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "ProjectDetailViewController.h"
#import "ProjectDetailModel.h"

@interface ProjectDetailViewController () {
    IBOutlet UIImageView *logoImageView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *kehuLabel;
    IBOutlet UILabel *dizhiLabel;
    IBOutlet UILabel *jianzhumianjiLabel;
    IBOutlet UILabel *xiaofangshebeiLabel;
    IBOutlet UILabel *anquanrenLabel;
    IBOutlet UILabel *phoneLabel;
    IBOutlet UILabel *deviceNumLabel;
    IBOutlet UILabel *tanceqiNumLabel;
    IBOutlet UILabel *baojiNumLabel;
    IBOutlet UILabel *guzhangNumLabel;
    
    ProjectDetailModel *projectDetailModel;
}

@end

@implementation ProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"项目详情";
    
    SetViewCorner(logoImageView, 30);
    
    [self sendRequestToGetData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewData {
    nameLabel.text = projectDetailModel.projectInfo.projectName;
    dizhiLabel.text = projectDetailModel.projectInfo.address;
    kehuLabel.text = projectDetailModel.projectInfo.customerName;
    jianzhumianjiLabel.text = projectDetailModel.projectInfo.space;
    xiaofangshebeiLabel.text = projectDetailModel.projectInfo.equipment;
    anquanrenLabel.text = projectDetailModel.projectInfo.dutyPerson;
    phoneLabel.text = projectDetailModel.projectInfo.telPhone;
    deviceNumLabel.text = [NSString stringWithFormat:@"%ld",(long)projectDetailModel.projectInfo.equipmentQty];
    tanceqiNumLabel.text = [NSString stringWithFormat:@"%ld",(long)projectDetailModel.projectInfo.detectorQty];
    baojiNumLabel.text = [NSString stringWithFormat:@"%ld",(long)projectDetailModel.projectInfo.alarmQty];
    guzhangNumLabel.text = [NSString stringWithFormat:@"%ld",(long)projectDetailModel.projectInfo.troubleQty];
}

#pragma mark -
- (void)sendRequestToGetData {
    ShowProcessHud;
    WeakSelf;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.projectID forKey:@"nodeId"];
    [dic setValue:@"0" forKey:@"nodeType"];
    [RequestManager sendPostRequestWithRequestName:[NSString stringWithFormat:@"http://%@/api/MonitoringProject/GetContainerData",UserIP] parameters:dic completeBlock:^(BOOL result, NSString *resultDesc, NSDictionary *dataDic) {
        HideProcessHud;
        
        projectDetailModel = [ProjectDetailModel mj_objectWithKeyValues:dataDic];
        [weakSelf setViewData];
        
    } failedBlock:^(NSError *error) {
        HideProcessHud
        [weakSelf showToast:ToastMsg_NetworkFailed];
    }];
}

@end
