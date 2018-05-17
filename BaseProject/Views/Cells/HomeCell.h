//
//  HomeCell.h
//  BaseProject
//
//  Created by Cinna on 2017/11/2.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *numLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *kehuLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UIButton *detailBtn;
@property (nonatomic, weak) IBOutlet UIButton *jiankongBtn;

@end
