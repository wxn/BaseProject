//
//  JiankongItemsView.m
//  BaseProject
//
//  Created by Cinna on 2017/11/4.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "JiankongItemsView.h"

#define ItemNum 3.0

#define RedBGColor @"#F7F1F1"
#define RedTextColor @"#EA6C75"
#define GreenBGColor @"#E8F6F8"
#define GreenTextColor @"#60C0C6"
#define BlueBGColor @"#E7F1F5"
#define BlueTextColor @"#56B3D9"
#define YellowBGColor @"#F9F2E5"
#define YellowTextColor @"#DDA550"


@implementation JiankongItemsView {
    NSMutableArray *valueLabelArray;
}

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray<Paramlist *> *)array {
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = [NSArray arrayWithArray:array];
        valueLabelArray = [NSMutableArray array];
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    for (NSInteger i = 0;i < _dataArray.count;i ++) {
        
        CGFloat btnWidth = (self.frame.size.width - 30)/3.0;
        CGFloat btnHeight = 50;
        
        CGFloat xIndex = i%3;
        CGFloat yIndex = ceilf(i/3);
        
        UIView *view = [self itemViewWithFrame:CGRectMake(xIndex * (btnWidth + 10), yIndex * (btnHeight + 10), btnWidth, btnHeight) index:i];
        
        [self addSubview:view];
        
    }
}

- (UIView *)itemViewWithFrame:(CGRect)frame index:(NSInteger)index {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    Paramlist *model = _dataArray[index];
    UIButton *btn = [CreateView createCustomBtnWithFrame:CGRectMake(5, frame.size.height/2 - 13, 26, 26) title:@"" image:nil titleColorStr:@"" fontSize:0 superView:view];
    [btn setImage:ImageNamed(@"wenduji_orange") forState:UIControlStateNormal];
    UILabel *name = [CreateView createLabelWithFrame:CGRectMake(25, 5, frame.size.width - 20, 20) text:model.paramName fontSize:13.0 textColorStr:ColorText_333333 superView:view];
    name.textAlignment = NSTextAlignmentCenter;
    
    UILabel *value = [CreateView createLabelWithFrame:CGRectMake(20, 25, frame.size.width - 20, 20) text:model.paramValue fontSize:13.0 textColorStr:ColorText_333333 superView:view];
    value.textAlignment = NSTextAlignmentCenter;
    [valueLabelArray addObject:value];
    NSInteger num = index % 4;
    switch (num) {
        case 0:
            name.textColor = ColorWithHexString(RedTextColor);
            value.textColor = ColorWithHexString(RedTextColor);
            view.backgroundColor = ColorWithHexString(RedBGColor);
            if ([model.paramName containsString:@"温度"]) {
                [btn setImage:ImageNamed(@"wenduji_orange") forState:UIControlStateNormal];
            }else if ([model.paramName containsString:@"相电压(V)"]) {
                [btn setImage:ImageNamed(@"dianya_orange") forState:UIControlStateNormal];
            }else if ([model.paramName containsString:@"相电流(A)"]) {
                [btn setImage:ImageNamed(@"dianliu_orange") forState:UIControlStateNormal];
            }else {
                [btn setImage:ImageNamed(@"tongyong_orange") forState:UIControlStateNormal];
            }
            break;
        case 1:
            name.textColor = ColorWithHexString(GreenTextColor);
            value.textColor = ColorWithHexString(GreenTextColor);
            view.backgroundColor = ColorWithHexString(GreenBGColor);
            if ([model.paramName containsString:@"温度"]) {
                [btn setImage:ImageNamed(@"wenduji_green") forState:UIControlStateNormal];
            }else if ([model.paramName containsString:@"相电压(V)"]) {
                [btn setImage:ImageNamed(@"dianya_green") forState:UIControlStateNormal];
            }else if ([model.paramName containsString:@"相电流(A)"]) {
                [btn setImage:ImageNamed(@"dianliu_green") forState:UIControlStateNormal];
            }else {
                [btn setImage:ImageNamed(@"tongyong_green") forState:UIControlStateNormal];
            }
            
            break;
        case 2:
            name.textColor = ColorWithHexString(BlueTextColor);
            value.textColor = ColorWithHexString(BlueTextColor);
            view.backgroundColor = ColorWithHexString(BlueBGColor);
            if ([model.paramName containsString:@"温度"]) {
                [btn setImage:ImageNamed(@"wenduji_blue") forState:UIControlStateNormal];
            }else if ([model.paramName containsString:@"相电压(V)"]) {
                [btn setImage:ImageNamed(@"dianya_blue") forState:UIControlStateNormal];
            }else if ([model.paramName containsString:@"相电流(A)"]) {
                [btn setImage:ImageNamed(@"dianliu_blue") forState:UIControlStateNormal];
            }else {
                [btn setImage:ImageNamed(@"tongyong_blue") forState:UIControlStateNormal];
            }
            break;
        case 3:
            name.textColor = ColorWithHexString(YellowTextColor);
            value.textColor = ColorWithHexString(YellowTextColor);
            view.backgroundColor = ColorWithHexString(YellowBGColor);
            if ([model.paramName containsString:@"温度"]) {
                [btn setImage:ImageNamed(@"wenduji_yellow") forState:UIControlStateNormal];
            }else if ([model.paramName containsString:@"相电压(V)"]) {
                [btn setImage:ImageNamed(@"dianya_yellow") forState:UIControlStateNormal];
            }else if ([model.paramName containsString:@"相电流(A)"]) {
                [btn setImage:ImageNamed(@"dianliu_yellow") forState:UIControlStateNormal];
            }else {
                [btn setImage:ImageNamed(@"tongyong_yellow") forState:UIControlStateNormal];
            }
            break;
            
        default:
            break;
    }
    return view;
}

- (void)reloadData:(NSArray<Paramlist *> *)array {
    for (NSInteger i=0;i<valueLabelArray.count;i ++) {
        if (array.count <= i)
            return;
        UILabel *label = valueLabelArray[i];
        Paramlist *model = array[i];
        label.text = model.paramValue;
    }
}

@end
