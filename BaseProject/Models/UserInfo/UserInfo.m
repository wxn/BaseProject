//
//  UserInfo.m
//  BaseProject
//
//  Created by Cinna on 2017/9/26.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+(instancetype)shareInstance
{
    static UserInfo *info;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        info = [[UserInfo alloc] init];
        [info getUserInfoFromDefaults];
    });
    return info;
}
//获取本地用户信息
- (void)getUserInfoFromDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userAccount = [defaults objectForKey:@"userAcount"];
    self.userPsw = [defaults objectForKey:@"userPsw"];
    self.ipPort = [defaults objectForKey:@"ipPort"];
    self.isAutoLogin = [[defaults objectForKey:@"isAutoLogin"] boolValue];
}

//保存用户信息至本地
- (void)writeToDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setValue:self.userAccount forKey:@"userAcount"];
    [defaults setValue:self.userPsw forKey:@"userPsw"];
    [defaults setValue:self.ipPort forKey:@"ipPort"];
    [defaults setValue:[NSNumber numberWithBool:self.isAutoLogin] forKey:@"isAutoLogin"];
    [defaults synchronize];
}
@end
