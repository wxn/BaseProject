//
//  DatePickView.h
//  BaseProject
//
//  Created by Cinna on 2017/10/26.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickViewDelegate;
;
@interface DatePickView : UIView
PropertyAssign id<DatePickViewDelegate>delegate;
-(void)setCurrentDate:(NSString *)date;
@end

@protocol DatePickViewDelegate <NSObject>

@optional
-(void)datePickDown;
- (void)pickdatestr:(NSString *)datestr;
@end
