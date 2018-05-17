//
//  Request_Const.h
//  BaseProject
//
//  Created by Cinna on 2017/9/26.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <UIKit/UIKit.h>

//加密拼接的字符串
UIKIT_EXTERN NSString *const Request_Secret;

#pragma mark - 接口Modular
//前缀不变，后面内容即是Modular



UIKIT_EXTERN NSString *const Modular_register;
UIKIT_EXTERN NSString *const Modular_login;
UIKIT_EXTERN NSString *const Modular_version;
UIKIT_EXTERN NSString *const Modular_readShop;
UIKIT_EXTERN NSString *const Modular_sms;
UIKIT_EXTERN NSString *const Modular_writeShop;
UIKIT_EXTERN NSString *const Modular_goods;
UIKIT_EXTERN NSString *const Modular_ractivity;
UIKIT_EXTERN NSString *const Modular_wactivity;
UIKIT_EXTERN NSString *const Modular_selectedtype;
UIKIT_EXTERN NSString *const Modular_picture;
UIKIT_EXTERN NSString *const Modular_home;
#pragma mark - 接口名称
//前缀不变，后面内容即是接口名称
UIKIT_EXTERN NSString *const RequestName_sendSms;
UIKIT_EXTERN NSString *const RequestName_addUserAccount;
UIKIT_EXTERN NSString *const RequestName_userAppLogin;
UIKIT_EXTERN NSString *const RequestName_ThirdLogin;
UIKIT_EXTERN NSString *const RequestName_checkVersionUpdate;
UIKIT_EXTERN NSString *const RequestName_queryHomeApp;
UIKIT_EXTERN NSString *const RequestName_updateUserPassword;
UIKIT_EXTERN NSString *const RequestName_queryCodeByAccount;
UIKIT_EXTERN NSString *const RequestName_queryUserExist;
UIKIT_EXTERN NSString *const RequestName_queryShopTypeList;
UIKIT_EXTERN NSString *const RequestName_queryByCustId;
UIKIT_EXTERN NSString *const RequestName_queryShopTypeInfo;
UIKIT_EXTERN NSString *const RequestName_queryBanklist;
UIKIT_EXTERN NSString *const RequestName_updateShopBusinessStatus;
UIKIT_EXTERN NSString *const RequestName_queryGoodsType;
UIKIT_EXTERN NSString *const RequestName_queryGoodsTypeByUp;
UIKIT_EXTERN NSString *const RequestName_updateShopGoodsType;
UIKIT_EXTERN NSString *const RequestName_sh_queryGoodsList;
UIKIT_EXTERN NSString *const RequestName_updateGoodsRecomm;
UIKIT_EXTERN NSString *const RequestName_updateForSale;
UIKIT_EXTERN NSString *const RequestName_querySonProList;
UIKIT_EXTERN NSString *const RequestName_addSonPro;
UIKIT_EXTERN NSString *const RequestName_updateSonPro;
UIKIT_EXTERN NSString *const RequestName_delSonPro;
UIKIT_EXTERN NSString *const RequestName_queryParProList;
UIKIT_EXTERN NSString *const RequestName_addParentPro;
UIKIT_EXTERN NSString *const RequestName_updateParentPro;
UIKIT_EXTERN NSString *const RequestName_delParentPro;

UIKIT_EXTERN NSString *const RequestName_addShopInfo;
UIKIT_EXTERN NSString *const RequestName_queryAppActivityList;
UIKIT_EXTERN NSString *const RequestName_addActivity;
UIKIT_EXTERN NSString *const RequestName_updateAppActivityStatus;
UIKIT_EXTERN NSString *const RequestName_shopAppLogin;
UIKIT_EXTERN NSString *const RequestName_queryAppActivityDetail;

UIKIT_EXTERN NSString *const RequestName_queryTypeList;
UIKIT_EXTERN NSString *const RequestName_querySelectPicListForApp;
UIKIT_EXTERN NSString *const RequestName_queryShopInfoByShopId;
UIKIT_EXTERN NSString *const RequestName_queryWaiMaiBusinessInfo;

