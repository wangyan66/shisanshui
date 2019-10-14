//
//  MenuViewController.m
//  shisanshui
//
//  Created by ios group on 2019/10/14.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import "MenuViewController.h"
#import "RankViewController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController
- (IBAction)startBtn:(UIButton *)sender {
}
- (IBAction)rankBtn:(id)sender {
    RankViewController *vc = [[RankViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)history:(UIButton *)sender {
}
- (IBAction)LogoutBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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
