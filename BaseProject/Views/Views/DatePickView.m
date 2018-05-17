//
//  DatePickView.m
//  BaseProject
//
//  Created by Cinna on 2017/10/26.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "DatePickView.h"

@implementation DatePickView{
    UIDatePicker *datePicker;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITE_COLOR;
        self.alpha = 1.0;
        [self initDatapick];
    }
    return self;
}

- (void)initDatapick {
    
    UIButton *canclebtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 35)];
    [canclebtn setTitle:AlertBtn_Cancle forState:UIControlStateNormal];
    [canclebtn setTitleColor:ColorWithHexString(ColorText_606060) forState:UIControlStateNormal];
    [canclebtn addTarget:self action:@selector(datedown) forControlEvents:UIControlEventTouchUpInside];
//    [canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    [self addSubview:canclebtn];
    
    

    UIButton *surebtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width - 60 , 0, 50, 35)];
    [surebtn setTitle:AlertBtn_Confirm forState:UIControlStateNormal];
    [surebtn setTitleColor:ColorWithHexString(ColorText_Blue34aeff) forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(chooseDate) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:surebtn];
    
    
    
    datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0,35,self.frame.size.width,216)];
    datePicker.datePickerMode = UIDatePickerModeDate ;
    datePicker.locale = [ NSLocale localeWithLocaleIdentifier : @"zh" ];
    [self addSubview:datePicker];
}

-(void)setCurrentDate:(NSString *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *resDate = [formatter dateFromString:date];
    [ datePicker setDate:resDate animated:NO];
}

- (void)datedown {
    if ([self.delegate respondsToSelector:@selector(datePickDown)]) {
        [self.delegate datePickDown];
    }
}

- (void)chooseDate {
    NSDate* date = datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    if ([self.delegate respondsToSelector:@selector(pickdatestr:)]) {
        [self.delegate pickdatestr:currentDateString];
    }
    
}

@end
