//
//  NetFailedView.m
//  XTWL_IOS_USER
//
//  Created by Cinna on 2017/10/11.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "NetFailedView.h"


@implementation NetFailedView {
    
    ReloadBlock reloadBlock;
}

- (instancetype)initNetFailedViewWithFrame:(CGRect)frame title:(NSString *)title reloadBlock:(ReloadBlock)block {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        reloadBlock = block;
        [self initNetFailedSubviewsWithTitle:title block:block];
    }
    return self;
}

- (instancetype)initEmptyViewWithFrame:(CGRect)frame imageName:(NSString *)imageStr title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = CLEAR_COLOR;
    }
    return self;
    
}

- (void)initNetFailedSubviewsWithTitle:(NSString *)title block:(void(^)())block {
    UILabel *label = [CreateView createLabelWithFrame:CGRectMake(0, 10, Screen_Width/2.0, 20) text:[NSString stringWithFormat:@"%@，",title] fontSize:FontSize_14 textColorStr:ColorText_606060 superView:self];
    label.textAlignment = NSTextAlignmentRight;
    UIButton *btn = [CreateView createCustomBtnWithFrame:CGRectMake(label.frame.size.width, 5, 70, 30) title:@"重新加载" image:nil titleColorStr:ColorText_Blue34aeff fontSize:FontSize_14 superView:self];
//    btn.backgroundColor = RED_COLOR;
    [btn addTarget:self action:@selector(reloadBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)reloadBtnClicked {
    
    if (reloadBlock) {
        [self removeFromSuperview];
        reloadBlock();
    }
}




@end
