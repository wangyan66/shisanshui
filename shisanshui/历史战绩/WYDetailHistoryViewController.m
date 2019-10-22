//
//  WYDetailHistoryViewController.m
//  shisanshui
//
//  Created by ios group on 2019/10/22.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import "WYDetailHistoryViewController.h"

@interface WYDetailHistoryViewController ()

@end

@implementation WYDetailHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxijiem"]];
    imageView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:imageView];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
