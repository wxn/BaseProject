//
//  RequestManager.m
//  XTWL_IOS_USER
//
//  Created by Cinna on 2017/9/14.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "RequestManager.h"
#import "AFNetworking.h"

@implementation RequestManager


/**
 发送Get请求
 
 @param urlStr 接口地址
 @param modular 接口板块
 @param requestName 接口名称
 @param parameters 接口所传参数，一般是Dictionary
 @param completeBlock 请求成功后的回调
 @param failedBlock 请求失败后的回调
 */
+ (void)sendGetRequestWithURLString:(NSString *)urlStr
                            modular:(NSString *)modular
                        requestName:(NSString*)requestName
                         parameters:(id)parameters
                      completeBlock:(CompleteBlock)completeBlock
                        failedBlock:(FailedBlock)failedBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"" parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}


/**
 发送Post请求

 @param urlStr 接口地址
 @param modular 接口板块
 @param requestName 接口名称
 @param parameters 接口所传参数，一般是Dictionary
 @param completeBlock 请求成功后的回调
 @param failedBlock 请求失败后的回调
 */
+ (void)sendPostRequestWithURLString:(NSString *)urlStr
                            modular:(NSString *)modular
                        requestName:(NSString*)requestName
                         parameters:(id)parameters
                      completeBlock:(CompleteBlock)completeBlock
                        failedBlock:(FailedBlock)failedBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"" parameters:@"" progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}


@end
