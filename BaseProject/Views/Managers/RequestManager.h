//
//  RequestManager.h
//  XTWL_IOS_USER
//
//  Created by Cinna on 2017/9/14.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RequestTimeoutInterval 20.0f

@interface RequestManager : NSObject

/**
 发送Get请求
 
 @param requestName 接口名称
 @param parameters 接口所传参数，一般是Dictionary
 @param completeBlock 请求成功后的回调
 @param failedBlock 请求失败后的回调
 */
+ (void)sendGetRequestWithRequestName:(NSString*)requestName
                          parameters:(NSDictionary *)parameters
                       completeBlock:(void (^)(BOOL result, NSString *resultDesc, NSDictionary *dataDic))completeBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;


+ (void)sendPostRequestWithRequestName:(NSString*)requestName
                               parameters:(NSDictionary *)parameters
                            completeBlock:(void (^)(BOOL result, NSString *resultDesc, NSDictionary *dataDic))completeBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

@end

