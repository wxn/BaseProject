//
//  JiankongItemsView.h
//  BaseProject
//
//  Created by Cinna on 2017/11/4.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiankongModel.h"

@interface JiankongItemsView : UIView

@property (nonatomic, strong)NSArray *dataArray;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray<Paramlist *> *)array;

- (void)reloadData:(NSArray<Paramlist *> *)array;

@end
