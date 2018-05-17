//
//  DecideString.m
//  BaseProject
//
//  Created by Cinna on 2017/9/19.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "DecideString.h"

@implementation DecideString
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//只包含文字
+ (BOOL) availableChineseStr:(NSString *)str
{
    
    NSString *regex = @"^[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

@end
