//
//  UIImgeView+MyImageView.m
//  XTWL_IOS_USER
//
//  Created by Cinna on 2017/9/28.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "UIImgeView+MyImageView.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation UIImageView (MyImageView)

- (void)sd_setImageWithURLStr:(NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder {
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder options:0];
}

//获取原图
- (void)sd_setOriginImageWithURLStr:(NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder {
    
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?p=0",urlStr]] placeholderImage:placeholder options:0];
}

- (void)sd_setImageWithURLStr:(NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder imageWidth:(CGFloat)width imageHeight:(CGFloat)height {
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?w=%f&h=%f",urlStr,width,height]] placeholderImage:placeholder options:0];
}

@end

