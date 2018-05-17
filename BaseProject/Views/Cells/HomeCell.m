//
//  HomeCell.m
//  BaseProject
//
//  Created by Cinna on 2017/11/2.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    SetViewBorder(_detailBtn);
    SetViewBorder(_jiankongBtn);
    
    SetViewCorner(_detailBtn, CornerRadius_3);
    SetViewCorner(_jiankongBtn, CornerRadius_3);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
