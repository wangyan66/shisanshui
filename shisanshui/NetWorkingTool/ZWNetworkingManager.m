//
//  ZWNetworkingManager.m
//  Qimokaola
//
//  Created by Administrator on 16/7/26.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "ZWNetworkingManager.h"
#import "UserManager.h"
@interface ZWNetworkingManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

static ZWNetworkingManager *_manager = nil;

@implementation ZWNetworkingManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.requestSerializer.timeoutInterval = 10.0;
        self.sessionManager.requestSerializer=[AFJSONRequestSerializer serializer];
        
    }
    return self;
}


+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ZWNetworkingManager alloc] init];
    });
    return _manager;
}


+ (NSURLSessionDataTask *)getWithURLString:(NSString *)url
                                    params:(id)params
                                  progress:(ProgressBlock)progress
                                   success:(SuccessBlock)success
                                   failure:(FailureBlock)failure {
    
    
    return [[ZWNetworkingManager sharedManager].sessionManager GET:url
                                                        parameters:params
                                                          progress:progress
                                                           success:success
                                                           failure:failure];
}

+ (NSURLSessionDataTask *)getWithURLString:(NSString *)url
                                   success:(SuccessBlock)success
                                   failure:(FailureBlock)failure {
    
    return [ZWNetworkingManager getWithURLString:url
                                          params:nil
                                        progress:nil success:success
                                         failure:failure];
    
}

+ (NSURLSessionDataTask *)getWithURLString:(NSString *)url
                                    params:(id)params
                                   success:(SuccessBlock)success
                                   failure:(FailureBlock)failure {
    
    return [ZWNetworkingManager getWithURLString:url
                                          params:params
                                        progress:nil
                                         success:success
                                         failure:failure];
}

+ (NSURLSessionDataTask *)postWithURLString:(NSString *)url
                                     params:(id)params
                                   progress:(ProgressBlock)preogress
                                    success:(SuccessBlock)success
                                    failure:(FailureBlock)failure {
    return [[ZWNetworkingManager sharedManager].sessionManager POST:url
                                                         parameters:params
                                                           progress:preogress
                                                            success:success
                                                            failure:failure];
}

+ (NSURLSessionDataTask *)postWithURLString:(NSString *)url
                                     params:(id)params
                                    success:(SuccessBlock)success
                                    failure:(FailureBlock)failure {
    
    
    
    return [ZWNetworkingManager postWithURLString:url
                                           params:params
                                         progress:nil
                                          success:success
                                          failure:failure];
}

+ (NSURLSessionDataTask *)postWithURLString:(NSString *)url
                                     params:(id)params
                  constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                                   progress:(ProgressBlock)progress
                                    success:(SuccessBlock)success
                                    failure:(FailureBlock)failure {
    
    return [[ZWNetworkingManager sharedManager].sessionManager POST:url
                                                         parameters:params
                                          constructingBodyWithBlock:block
                                                           progress:progress
                                                            success:success
                                                            failure:false];
    
}

+ (BOOL)isNetWorkAvailable {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable;
}


@end
