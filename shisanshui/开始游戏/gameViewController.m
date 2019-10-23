//
//  gameViewController.m
//  shisanshui
//
//  Created by 王焱 on 2019/10/15.
//  Copyright © 2019年 王焱. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "gameViewController.h"
#import "ZWAPIRequestTool.h"
#import "UserManager.h"
#import "ZWHUDTool.h"
@interface gameViewController ()
@property (nonatomic,assign)int identifier;
@property (nonatomic,strong) NSDictionary *data;
@property (nonatomic,strong) NSArray *card;
@end

@implementation gameViewController
- (IBAction)sendPoker:(id)sender {
    __weak __typeof(self) weakSelf = self;
    NSString *Str = _data[@"id"];
    self.identifier = Str.intValue;
    NSDictionary *headers = @{ @"content-type": @"application/json" };
    NSDictionary *parameters = _data;
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://47.101.140.66/handle/hello2"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                        weakSelf.card =responseObject[@"card"];
                                                        [weakSelf send];
                                                        
                                                    }
                                                }];
    [dataTask resume];
    
}
//发送牌
- (void)send{
    NSDictionary *headers = @{ @"content-type": @"application/json",
                               @"x-auth-token": [UserManager sharedManager].token };
    NSDictionary *parameters = @{ @"id": [NSNumber numberWithInt:_identifier],
                                  @"card": _card};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.shisanshui.rtxux.xyz/game/submit"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        
                                                        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                        NSLog(@"send card response%@",responseObject);
                                                
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                    NSTimeInterval kTimeIntervalShort = 0.8;
                                                [[ZWHUDTool showPlainHUDInView:[UIApplication sharedApplication].keyWindow text:@"出牌成功"] hideAnimated:YES afterDelay:kTimeIntervalShort];
                                                            [self.navigationController popViewControllerAnimated:YES];
                                                        });
                                                        
                                                    }
                                                }];
    [dataTask resume];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"当前战局";
    
    [self getPoker];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)getPoker{
    __weak __typeof(self) weakSelf = self;
    NSLog(@"token:%@",[UserManager sharedManager].token);
    NSDictionary *headers = @{ @"x-auth-token": [UserManager sharedManager].token};

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.shisanshui.rtxux.xyz/game/open"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = ( NSHTTPURLResponse *) response;
                                                        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                        NSLog(@"response%@",responseObject);
                                                        
                                                        weakSelf.data = responseObject[@"data"];
                                                    }
                                                }];
    [dataTask resume];
    
}
- (void)AIPoker:(NSDictionary *)data{
    [ZWAPIRequestTool requestPokerWithData:data result:^(id response, BOOL success) {
        NSLog(@"response%@",response);
    }];
    
}
@end
