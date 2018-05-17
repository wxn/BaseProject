//
//  UIImgeView+MyImageView.h
//  XTWL_IOS_USER
//
//  Created by Cinna on 2017/9/28.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MyImageView)

//获取压缩后的图，即后面不加后缀
- (void)sd_setImageWithURLStr:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder;
//获取原图
- (void)sd_setOriginImageWithURLStr:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder;
//传入宽+高
- (void)sd_setImageWithURLStr:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder imageWidth:(CGFloat)width imageHeight:(CGFloat)height;

@end

