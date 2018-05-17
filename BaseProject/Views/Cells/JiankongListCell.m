//
//  JiankongListCell.m
//  BaseProject
//
//  Created by Cinna on 2017/11/4.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "JiankongListCell.h"

@implementation JiankongListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    SetViewCorner(_numLabel, 15.0);
    
    SetViewBorder(_detailBtn);
    SetViewBorder(_resetBtn);
    SetViewBorder(_fenzhaBtn);
    
    SetViewCorner(_detailBtn, CornerRadius_3);
    SetViewCorner(_resetBtn, CornerRadius_3);
    SetViewCorner(_fenzhaBtn, CornerRadius_3);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
