//
//  WYtitleView.m
//  shisanshui
//
//  Created by ios group on 2019/10/14.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import "WYtitleView.h"

@implementation WYtitleView

+(instancetype)loadView{
    return [[[NSBundle mainBundle] loadNibNamed:@"WYtitleView" owner:self options:nil] lastObject];
    // lastObject 可改为 firstObject，该数组只有一个元素，写哪个都行
}

@end
