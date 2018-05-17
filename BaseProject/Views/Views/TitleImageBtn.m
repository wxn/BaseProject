//
//  TitleImageBtn.m
//  BaseProject
//
//  Created by Cinna on 2017/9/18.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "TitleImageBtn.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation TitleImageBtn
{
    
    NSString *imageUrlStr;
    UIColor *titleColor;
    NSString *btnTitle;
    UIImageView *btnImageView;
    NSString *imageNameStr;
    CGFloat imageW;
    CGFloat topH;
    CGFloat titleHeight;
    CGFloat titleTop;
    
}
- (instancetype)initWithFrame: (CGRect)frame title: (NSString *)title titleColor: (UIColor *)color imageUrlStr: (NSString *)urlStr imageName: (NSString *)imageName imageWidth: (CGFloat)imageWidth topHeight: (CGFloat )top titleHeight: (CGFloat)titleheight titleTop: (CGFloat)titletop
{
    self = [super initWithFrame:frame];
    if (self) {
        btnTitle = title;
        titleColor = color;
        imageUrlStr = urlStr;
        imageNameStr = imageName;
        imageW = imageWidth;
        topH = top;
        titleHeight = titleheight;
        titleTop = titletop;
        [self initBtnSubviews];
        
    }
    return self;

}
- (void)initBtnSubviews {
    
    btnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - imageW/2, topH, imageW, imageW)];
    [self addSubview:btnImageView];
    
    if(imageUrlStr.length > 0)
        [btnImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:imageNameStr]];
    else
    {
        if(imageNameStr > 0)
            [btnImageView setImage:[UIImage imageNamed:imageNameStr]];
//        else
//            [btnImageView setImage:Image_DefaultPicture1];
    }
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    self.titleLabel.font = Font11;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self setTitle:btnTitle forState:UIControlStateNormal];

}
-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    btnImageView.image = image;
}



-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, CGRectGetMaxY(btnImageView.frame)+titleTop, self.frame.size.width, titleHeight);//文本的位置大小
}


@end
