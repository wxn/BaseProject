//
//  NetFailedView.h
//  XTWL_IOS_USER
//
//  Created by Cinna on 2017/10/11.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReloadBlock) ();
@interface NetFailedView : UIView

//初始化通用的网络请求失败界面
- (instancetype)initNetFailedViewWithFrame:(CGRect)frame title:(NSString *)title reloadBlock:(ReloadBlock)block;

/**
 初始化为空界面

 @param frame frame
 @param imageStr 图片 为nil不显示
 @param title 文案 为nil不显示
 */
- (instancetype)initEmptyViewWithFrame:(CGRect)frame imageName:(NSString *)imageStr title:(NSString *)title;





@end
