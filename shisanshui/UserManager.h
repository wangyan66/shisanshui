//
//  UserManager.h
//  shisanshui
//
//  Created by ios group on 2019/10/14.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject
@property (nonatomic,strong) NSString *token;
+ (instancetype)sharedManager;

@end


NS_ASSUME_NONNULL_END
