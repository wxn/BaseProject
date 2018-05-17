//
//  JiankongListCell.h
//  BaseProject
//
//  Created by Cinna on 2017/11/4.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiankongItemsView.h"

@interface JiankongListCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *numLabel;
@property (nonatomic, weak) IBOutlet UILabel *biaodizhiLabel;
@property (nonatomic, weak) IBOutlet UILabel *quyuLabel;
@property (nonatomic, weak) IBOutlet UILabel *weizhiLabel;
@property (nonatomic, weak) IBOutlet UILabel *stateLabel;

@property (nonatomic, weak) IBOutlet UIView *bottomView;
@property (nonatomic, weak) IBOutlet UIButton *detailBtn;
@property (nonatomic, weak) IBOutlet UIButton *resetBtn;
@property (nonatomic, weak) IBOutlet UIButton *fenzhaBtn;

@property (nonatomic, weak) IBOutlet UILabel *operationLabel;

@property (nonatomic, strong)IBOutlet JiankongItemsView *itemsView;

@end
