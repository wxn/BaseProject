//
//  RequestManager.m
//  XTWL_IOS_USER
//
//  Created by Cinna on 2017/9/14.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "RequestManager.h"
#import "AFNetworking.h"

#import<CommonCrypto/CommonDigest.h>

@implementation RequestManager

+ (instancetype)manager {
    return [[self alloc] init];
}

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
                         failedBlock:(void (^)(NSError *error))failedBlock {
    requestName = [requestName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = RequestTimeoutInterval;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [manager GET:requestName parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"[" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"]\"" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if (completeBlock) {
            BOOL result = [responseDic[@"result"] boolValue]; completeBlock(result,responseDic[@"message"],responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData * data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"服务器的错误原因:%@",str);
        if (failedBlock) {
            
            failedBlock(error);
        }
    }];
}


+ (void)sendPostRequestWithRequestName:(NSString*)requestName
                            parameters:(NSDictionary *)parameters
                         completeBlock:(void (^)(BOOL result, NSString *resultDesc, NSDictionary *dataDic))completeBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];//不需要，添加会报错
    [manager.requestSerializer setValue:@"acrel" forHTTPHeaderField:@"username"];
    [manager.requestSerializer setValue:@"acrel001" forHTTPHeaderField:@"password"];
    manager.requestSerializer.timeoutInterval = RequestTimeoutInterval;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];;
    
    [manager POST:requestName parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"]\"" withString:@"]"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if (completeBlock) {
            completeBlock(YES,nil,responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
    
}


@end

