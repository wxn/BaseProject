//
//  UserInfo.h
//  BaseProject
//
//  Created by Cinna on 2017/9/26.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
PropertyCopy NSString *ipPort;//端口
PropertyCopy NSString *userAccount;//登录的账号
PropertyCopy NSString *userPsw;
PropertyCopy NSString *userID;
PropertyCopy NSString *userRealName;
PropertyCopy NSString *userRole;//管理员
PropertyAssign BOOL isAutoLogin;

+(instancetype)shareInstance;
- (void)getUserInfoFromDefaults;
- (void)writeToDefaults;
@end
