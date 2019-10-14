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

//// 请求验证码
//+ (void)requestSendCodeWithPhone:(NSString *)phone result:(APIRequestResult)result;
//+ (void)requestLoginWithPhone:(NSString *)phone result:(APIRequestResult)result;
//+ (void)requestTextTranslateByText:(NSString *)text sourceLan:(NSString *)sl    targetLan:(NSString *)tl result:(APIRequestResult)result;
//+ (void)requestPictureTranslateByPicture:(UIImage *)image result:(APIRequestResult)result;
//+ (void)requestTouristRecognizeBy:(UIImage *)image result:(APIRequestResult)result;
//+ (void)requestLikeListResult:(APIRequestResult)result;
+ (void)requestLoginWithPhoneNumber:(NSString *)phone password:(NSString *)password result:(APIRequestResult)result;
+ (void)requestRegisterWithPhoneNumber:(NSString *)phone password:(NSString *)password result:(APIRequestResult)result;
@end
