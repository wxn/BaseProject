//
//  TitleImageBtn.h
//  BaseProject
//
//  Created by Cinna on 2017/9/18.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleImageBtn : UIButton
//frame 整个view的frame  title标题 color文字颜色 urlstr图片链接 imagename本地图片 imagewidth图片大小(宽高等比) top 图片距顶 titleheight文字高度 titletop 文字距图片高度
- (instancetype)initWithFrame: (CGRect)frame
                        title: (NSString *)title
                   titleColor: (UIColor *)color
                  imageUrlStr: (NSString *)urlStr
                    imageName: (NSString *)imageName
                   imageWidth: (CGFloat)imageWidth
                    topHeight: (CGFloat )top
                  titleHeight: (CGFloat)titleheight
                     titleTop: (CGFloat)titletop;
@end
