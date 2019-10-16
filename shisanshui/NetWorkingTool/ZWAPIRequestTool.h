//
//  ZWAPIRequestTool.h
//  Qimokaola
//
//  Created by Administrator on 16/8/28.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWNetworkingManager.h"

typedef void(^APIRequestResult)(id response, BOOL success);

@interface ZWAPIRequestTool : NSObject
@property (nonatomic,strong) NSString *token;


+ (void)requestLoginWithPhoneNumber:(NSString *)phone password:(NSString *)password result:(APIRequestResult)result;
+ (void)requestRegisterWithPhoneNumber:(NSString *)phone password:(NSString *)password result:(APIRequestResult)result;
+ (void)requestRankInfo:(APIRequestResult)result;
+ (void)requestPokerWithData:(NSDictionary *)dic result:(APIRequestResult)result;

@end
