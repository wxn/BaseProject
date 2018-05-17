//
//  AppInfo.h
//  BaseProject
//
//  Created by Cinna on 2017/9/26.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

PropertyCopy NSString *deviceToken;

PropertyAssign BOOL isShowBaojingView;

+(instancetype)shareInstance;

@end
