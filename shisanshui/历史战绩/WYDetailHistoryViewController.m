//
//  WYDetailHistoryViewController.m
//  shisanshui
//
//  Created by 王焱 on 2019/10/23.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import "WYDetailHistoryViewController.h"

@interface WYDetailHistoryViewController ()

@end

@implementation WYDetailHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxijiem"]];
    imageView.frame = UIScreen.mainScreen.bounds;
    [self.view addSubview:imageView];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
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
