//
//  PriceUtil.h
//  BaseProject
//
//  Created by Cinna on 2017/9/18.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceUtil : NSObject

+ (NSString *)rmbPriceStrWithStr:(NSString *)price;

+ (NSString *)rmbPriceStrWithFloat:(float)price;

@end
