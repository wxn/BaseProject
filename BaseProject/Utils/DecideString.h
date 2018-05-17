//
//  DecideString.h
//  BaseProject
//
//  Created by Cinna on 2017/9/19.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DecideString : NSObject
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
+ (BOOL) availableChineseStr:(NSString *)str;
@end
