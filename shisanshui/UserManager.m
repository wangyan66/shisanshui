//
//  UserManager.m
//  shisanshui
//
//  Created by ios group on 2019/10/14.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
+ (instancetype)sharedManager {
    static UserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserManager alloc]init];
    });
    return manager;
}

@end
