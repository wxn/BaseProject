//
//  OpenShopInfo.h
//  BaseProject
//
//  Created by Cinna on 2017/10/14.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenShopInfo : NSObject
+(instancetype)shareInstance;
PropertyCopy NSString *shopType;//店铺种类
PropertyCopy NSString *shopGoodsType;//店铺经营商品种类
PropertyCopy NSString *shopName;//店铺名称
PropertyCopy NSString *shopLat;//店铺纬度
PropertyCopy NSString *shopLong;//店铺经度
PropertyCopy NSString *shopAddress;//店铺地址
PropertyCopy NSString *shopUserTel;//联系人电话
PropertyCopy NSString *shopUserName;//联系人
PropertyCopy NSString *shopDeliveryType;//店铺配送方式
PropertyCopy NSString *shopTypeName;//店铺商品种类
PropertyAssign NSInteger shopInfoProgress;//商铺信息填写程度  0 未填  1 部分 2完全填写完
PropertyAssign NSInteger shopTypeProgress;//商铺信息填写程度  0 未填  1 部分 2完全填写完


PropertyAssign BOOL isOpenW;//是否开通外卖
PropertyAssign BOOL isOpenT;//是否开通团购
PropertyAssign BOOL isOpenS;//是否开通商城

PropertyCopy NSString *bankUser;//开户人
PropertyCopy NSString *bankCardNum;//银行卡号
PropertyCopy NSString *bankName;//银行
PropertyCopy NSString *BankSecName;//支行
PropertyAssign NSInteger bankinfoProgress;//银行信息填写程度  0 未填  1 部分 2完全填写完

PropertyCopy NSString *CompanyUser;//法人姓名
PropertyCopy NSString *CompanyUserNum;//法人身份证
PropertyCopy NSString *FoodNum;//餐饮许可证号
PropertyCopy NSString *FoodAddress;//餐饮许可证所在地
PropertyAssign NSInteger FarenAdviceProgress;//法人代表信息  0 未填  1 部分 2完全填写完

PropertyCopy NSString *SaleNum;//营业执照号
PropertyCopy NSString *SaleAddress;//营业类执照所在地
PropertyAssign NSInteger count;//照片数量
PropertyAssign NSInteger SaleProgress;//营业类信息  0 未填  1 部分 2完全填写完
PropertyAssign NSInteger shopQuatProgress;//商铺资质信息填写程度  0 未填  1 部分 2完全填写完

PropertyStrong NSMutableArray *typeArray;

PropertyCopy NSString *SupTypeId;  //第一大类选中的id 选择商品经营品类

PropertyStrong NSMutableArray *SecsupTypeIDArr; //第二大类存放选中的id  最多选两个 选择商品经营品类
PropertyStrong NSMutableArray *SecsupTypeNmaeArr; //第二大类存放选中的name  最多选两个 选择商品经营品类






- (void)writeToDefaults;
@end
