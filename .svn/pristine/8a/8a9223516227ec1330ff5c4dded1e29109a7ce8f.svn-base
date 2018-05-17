//
//  RequestManager.h
//  XTWL_IOS_USER
//
//  Created by Cinna on 2017/9/14.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject

typedef void (^CompleteBlock)(NSString *resultCode, NSDictionary *headDic, NSDictionary *bodyDic);

typedef void (^FailedBlock)(NSError *error);

@property (nonatomic, copy) CompleteBlock completeBlock;

@property (nonatomic, copy) FailedBlock failedBlock;

@end
