//
//  CreateView.h
//  XTWL_IOS_USER
//
//  Created by Cinna on 2017/9/15.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateView : NSObject

+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                         fontSize:(float)size
                     textColorStr:(NSString *)colorStr
                        superView:(UIView *)superView;

//一般用于section的footerView
+ (UIView *)createSeparateViewWithOrignY:(float)originY superView:(UIView *)superView;

+ (UIButton *)createCustomBtnWithFrame:(CGRect)frame
                                 title:(NSString *)title
                                 image:(UIImage *)image
                         titleColorStr:(NSString *)colorStr
                              fontSize:(CGFloat)size
                             superView:(UIView *)superView;

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame image:(UIImage *)image  superView:(UIView *)superView;

+ (UIView *)createLineViewWithFrame:(CGRect)frame colorStr:(NSString *)colorStr superView:(UIView *)superView;

+ (UITextField *)createTextFieldWithFram: (CGRect)frame
                                delegate: (id)delegate
                             placeholder: (NSString *)placeholder
                               textColor: (NSString *)textColor
                                    font: (CGFloat)font
                               superView: (UIView *)superView;
@end

