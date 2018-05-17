//
//  OpenShopInfo.m
//  BaseProject
//
//  Created by Cinna on 2017/10/14.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "OpenShopInfo.h"

@implementation OpenShopInfo
+(instancetype)shareInstance
{
    static OpenShopInfo *info;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        info = [[OpenShopInfo alloc] init];
        [info getUserInfoFromDefaults];
    });
    return info;
}
//获取本地用户信息
- (void)getUserInfoFromDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.shopType = [defaults objectForKey:@"shopType"];
    self.shopGoodsType = [defaults objectForKey:@"shopGoodsType"];
    self.shopName = [defaults objectForKey:@"shopName"];
    self.shopLat = [defaults objectForKey:@"shopLat"];
    self.shopLong = [defaults objectForKey:@"shopLong"];
    self.shopAddress = [defaults objectForKey:@"shopAddress"];
    self.shopUserTel = [defaults objectForKey:@"shopUserTel"];
    self.shopUserName = [defaults objectForKey:@"shopUserName"];
    self.shopDeliveryType = [defaults objectForKey:@"shopDeliveryType"];
     self.shopTypeName = [defaults objectForKey:@"shopTypeName"];
   self.bankUser = [defaults objectForKey:@"bankUser"];
    self.bankCardNum = [defaults objectForKey:@"bankCardNum"];
    self.bankName = [defaults objectForKey:@"bankName"];
    self.BankSecName = [defaults objectForKey:@"BankSecName"];
    self.isOpenW = [defaults boolForKey:@"isOpenW"];
    self.isOpenT = [defaults boolForKey:@"isOpenT"];
    self.isOpenS = [defaults boolForKey:@"isOpenS"];
    self.FoodNum = [defaults objectForKey:@"FoodNum"];
    self.FoodAddress = [defaults objectForKey:@"FoodAddress"];
    self.SaleNum = [defaults objectForKey:@"SaleNum"];
    self.SaleAddress = [defaults objectForKey:@"SaleAddress"];
    self.count = [defaults integerForKey:@"count"];
    self.shopInfoProgress = [defaults integerForKey:@"shopInfoProgress"];
    self.bankinfoProgress = [defaults integerForKey:@"bankinfoProgress"];
    self.shopQuatProgress = [defaults integerForKey:@"shopQuatProgress"];
    self.FarenAdviceProgress = [defaults integerForKey:@"FarenAdviceProgress"];
    self.SaleProgress = [defaults integerForKey:@"SaleProgress"];
    self.SupTypeId = [defaults objectForKey:@"SupTypeId"];

    
    
    self.SecsupTypeNmaeArr = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"SecsupTypeNmaeArr"]];
    self.SecsupTypeIDArr = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"SecsupTypeIDArr"]];
    self.typeArray = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"typeArray"]];

    
}

//保存用户信息至本地
- (void)writeToDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setValue:self.shopType forKey:@"shopType"];
    [defaults setValue:self.shopGoodsType forKey:@"shopGoodsType"];
    [defaults setValue:self.shopName forKey:@"shopName"];
    [defaults setValue:self.shopLat forKey:@"shopLat"];
    [defaults setValue:self.shopLong forKey:@"shopLong"];
    [defaults setValue:self.shopAddress forKey:@"shopAddress"];
    [defaults setValue:self.shopUserTel forKey:@"shopUserTel"];
    [defaults setValue:self.shopUserName forKey:@"shopUserName"];
    [defaults setValue:self.shopDeliveryType forKey:@"shopDeliveryType"];
    [defaults setValue:self.shopTypeName forKey:@"shopTypeName"];
    [defaults setValue:self.bankUser forKey:@"bankUser"];
    [defaults setValue:self.bankCardNum forKey:@"bankCardNum"];
    [defaults setValue:self.bankName forKey:@"bankName"];
    [defaults setValue:self.BankSecName forKey:@"BankSecName"];
    [defaults setBool:self.isOpenW forKey:@"isOpenW"];
    [defaults setBool:self.isOpenT forKey:@"isOpenT"];
    [defaults setBool:self.isOpenS forKey:@"isOpenS"];
    [defaults setValue:self.FoodNum forKey:@"FoodNum"];
    [defaults setValue:self.FoodAddress forKey:@"FoodAddress"];
    [defaults setValue:self.SaleNum forKey:@"SaleNum"];
    [defaults setValue:self.SaleAddress forKey:@"SaleAddress"];
    [defaults setInteger:self.count forKey:@"count"];
    
    [defaults setObject:self.typeArray forKey:@"typeArray"];
    [defaults setObject:self.SecsupTypeIDArr forKey:@"SecsupTypeIDArr"];
    [defaults setObject:self.SecsupTypeNmaeArr forKey:@"SecsupTypeNmaeArr"];
    
    [defaults setValue:self.SupTypeId forKey:@"SupTypeId"];
    
    [defaults setInteger:self.shopInfoProgress forKey:@"shopInfoProgress"];
    [defaults setInteger:self.bankinfoProgress forKey:@"bankinfoProgress"];
    [defaults setInteger:self.shopQuatProgress forKey:@"shopQuatProgress"];
    [defaults setInteger:self.FarenAdviceProgress forKey:@"FarenAdviceProgress"];
    [defaults setInteger:self.SaleProgress forKey:@"SaleProgress"];
    [defaults synchronize];
}

@end
