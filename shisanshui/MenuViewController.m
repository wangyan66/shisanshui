//
//  MenuViewController.m
//  shisanshui
//
//  Created by ios group on 2019/10/14.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import "MenuViewController.h"
#import "RankViewController.h"
#import "gameViewController.h"
#import "WYHistoryViewController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController
- (IBAction)startBtn:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    gameViewController *vc =[sb instantiateViewControllerWithIdentifier:@"gameViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)rankBtn:(id)sender {
    RankViewController *vc = [[RankViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)history:(UIButton *)sender {
    WYHistoryViewController *vc = [[WYHistoryViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)LogoutBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]init];
    //backButtonItem.style = UIBarButtonItemStylePlain;
   // backButtonItem.image = [UIImage imageNamed:@"back"];
    backButtonItem.tintColor = [UIColor grayColor];
    self.navigationItem.backBarButtonItem = backButtonItem;
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
