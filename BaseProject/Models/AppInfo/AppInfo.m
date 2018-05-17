//
//  AppInfo.m
//  BaseProject
//
//  Created by Cinna on 2017/9/26.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

+(instancetype)shareInstance
{
    static AppInfo *info;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        info = [[AppInfo alloc] init];
    });
    return info;
}

@end
