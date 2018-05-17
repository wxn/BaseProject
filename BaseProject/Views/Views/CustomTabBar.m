//
//  CustomTabBar.m
//  XTWL_XFJY
//
//  Created by xuntiangwangluo on 14-11-15.
//  Copyright (c) 2014年 xuntiangwangluo. All rights reserved.
//

#import "CustomTabBar.h"
#import "AppDelegate.h"
#import "SDWebImageManager.h"

#define BarBtnWidth Screen_Width/3

static CustomTabBar *cusTabBar = nil;

@interface CustomTabBar ()

PropertyStrong NSArray *systemNormalImageNameArray;
PropertyStrong NSArray *systemSelectImageNameArray;
PropertyStrong NSArray *systemTitleArray;

@end

@implementation CustomTabBar

+ (CustomTabBar *)sharedInstance {
    @synchronized(self) {
        
        if (cusTabBar == nil) {
            cusTabBar = [[[self class] alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 50)];
            cusTabBar.systemNormalImageNameArray = @[@"home", @"baojing", @"wode"];
            cusTabBar.systemSelectImageNameArray = @[@"home_1", @"baojing_1", @"wode_1"];
            cusTabBar.systemTitleArray = @[@"首页", @"报警", @"我的"];
            [cusTabBar setBackgroundColor:[UIColor whiteColor]];
            [cusTabBar initSubView];
        }
    }
    
    return cusTabBar;
}

#pragma mark 创建view
- (void)initSubView {
    [CreateView createLineViewWithFrame:CGRectMake(0, 0, Screen_Width, 0.5) colorStr:ColorLine_e0e0e0 superView:self];
    for (NSInteger i = 0;i < self.systemTitleArray.count;i ++) {
        
        [self createImageViewWithFrame:CGRectMake(BarBtnWidth * i, 0, BarBtnWidth, 48) index:i tag:i + 100];
    }
    self.selectIndex = 0;
}

//是否显示小圆点
- (void)createImageViewWithFrame:(CGRect)frame index:(NSInteger)index tag:(long)tag {
    
    UIView *btnView = [[UIView alloc]initWithFrame:frame];
    btnView.tag = tag;
    [self addSubview:btnView];
    
    UIImageView *tempImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 21, 21)];
    
    tempImgView.userInteractionEnabled = NO;
    tempImgView.center = CGPointMake(BarBtnWidth/2, 18);
    tempImgView.tag = 110;
    [btnView addSubview:tempImgView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 15)];
    titleLabel.font = Font14;
    titleLabel.tag = 112;
    titleLabel.textColor = RED_COLOR;
    [btnView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTap:)];
    [btnView addGestureRecognizer:tapGes];
    //显示数量的小圆点
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(tempImgView.frame.origin.x + tempImgView.frame.size.width - 10, 6, 16, 16)];
    numLabel.tag = 111;
    SetViewCorner(numLabel, 8);
    numLabel.backgroundColor = ColorWithHexString(Color_PriceFF2622);
    numLabel.font = Font(10);
    numLabel.textColor = [UIColor whiteColor];
    numLabel.textAlignment = NSTextAlignmentCenter;
    [btnView addSubview:numLabel];
    numLabel.hidden = YES;
    
    tempImgView.image = ImageNamed(_systemNormalImageNameArray[index]);
    titleLabel.text = _systemTitleArray[index];
}

- (void)imgTap:(UITapGestureRecognizer *)tapGes {
    
    UIView *view = (UIView *)tapGes.view;
    _selectIndex = view.tag-100;
    
    if ([self.delegate respondsToSelector:@selector(didSelectIndex:)])
    {
        [self.delegate didSelectIndex:view.tag-100];
    }
}

- (void)setSelectIndex:(NSInteger)index {
    if (index == 3) {
//        AppDelegate *app = Get_App;
//        if (!app.curLoginStatus) {
//            return;
//        }
    }
    _selectIndex = index;
    
    [self selectImageViewAtIndex:index];
}

- (void)selectImageViewAtIndex:(NSInteger)index {
    
    for (NSInteger i = 0;i<_systemTitleArray.count;i++) {
        UIImageView *imageView = [[self viewWithTag:100 + i] viewWithTag:110];
        UILabel *titleLabel = [[self viewWithTag:100 + i] viewWithTag:112];
            
        imageView.image = (index == i ? ImageNamed(self.systemSelectImageNameArray[i]) : ImageNamed(self.systemNormalImageNameArray[i]));
        titleLabel.textColor = (index == i ? BLUE_COLOR : ColorWithHexString(ColorText_606060));
    }
}


- (void)setNumAtIndex:(NSInteger)index num:(long)num {
    
    UILabel *numLabel = [[self viewWithTag:100] viewWithTag:111];
    numLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
    if(num == 0 || numLabel.text.length <= 0)
        numLabel.hidden = YES;
    else
        numLabel.hidden = NO;
}

/*
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
