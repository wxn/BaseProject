//
//  UIColor+MyColor.h
//  HealthPilot
//
//  Created by quanwangwulian on 14-3-6.
//  Copyright (c) 2014年 quanwangwulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MyColor)

//16进制颜色转换
+ (UIColor *)colorWithHexString:(NSString *)color;
//设置纯色的图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
