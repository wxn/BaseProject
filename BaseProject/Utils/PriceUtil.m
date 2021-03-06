//
//  PriceUtil.m
//  BaseProject
//
//  Created by Cinna on 2017/9/18.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "PriceUtil.h"

@implementation PriceUtil

+ (NSString *)rmbPriceStrWithStr:(NSString *)price {
    return [NSString stringWithFormat:@"￥%@",AvailableString(price)];
}

+ (NSString *)rmbPriceStrWithFloat:(float)price {
    return [NSString stringWithFormat:@"￥%.2f",price];
}

@end
