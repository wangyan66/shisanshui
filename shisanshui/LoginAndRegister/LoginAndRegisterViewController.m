//
//  LoginAndRegisterViewController.m
//  shisanshui
//
//  Created by 王焱 on 2019/10/13.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#import "ZWAPIRequestTool.h"
#import "MenuViewController.h"
#import "UserManager.h"
#import "ZWHUDTool.h"
@interface LoginAndRegisterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *line_1;
@property (weak, nonatomic) IBOutlet UILabel *line2;
@property (weak, nonatomic) IBOutlet UIButton *loginOrRegisterBtn;
@property (weak, nonatomic) IBOutlet UITextField *UserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (assign, nonatomic) BOOL isLogin;
@end

@implementation LoginAndRegisterViewController
- (IBAction)LoginBtnSelected:(UIButton *)sender {
    _line_1.hidden = false;
    _line2.hidden = true;
    _isLogin = true;
    [_loginOrRegisterBtn setTitle:@"点击登录" forState:UIControlStateNormal];
}
- (IBAction)RegisterSelected:(UIButton *)sender {
    _line_1.hidden = true;
    _line2.hidden = false;
    _isLogin = false;
    [_loginOrRegisterBtn setTitle:@"点击注册" forState:UIControlStateNormal];
    
}
- (IBAction)LoginOrRegister:(UIButton *)sender {
    __weak __typeof(self) weakSelf = self;
    if (_isLogin) {
        [ZWAPIRequestTool requestLoginWithPhoneNumber:self.UserNameTextField.text password:self.PasswordTextField.text result:^(id response, BOOL success) {
            NSLog(@"Login response:%@",response);
            NSString *codeStr = response[@"status"];
            int code =[codeStr intValue];
            NSDictionary *data = response[@"data"];
            NSLog(@"code%@",code);
            if (success&&code==0) {
                NSTimeInterval kTimeIntervalShort = 1.0;
                [[ZWHUDTool showPlainHUDInView:[UIApplication sharedApplication].keyWindow text:@"登录成功"] hideAnimated:YES afterDelay:kTimeIntervalShort];
                [UserManager sharedManager].token = data[@"token"];
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MenuViewController *vc =[sb instantiateViewControllerWithIdentifier:@"MenuViewController"];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                [self presentViewController:nav animated:YES completion:nil];
            }
        }];
    }else{
        [ZWAPIRequestTool requestRegisterWithPhoneNumber:self.UserNameTextField.text password:self.PasswordTextField.text result:^(id response, BOOL success) {
            NSTimeInterval kTimeIntervalShort = 1.0;
            [[ZWHUDTool showPlainHUDInView:[UIApplication sharedApplication].keyWindow text:@"注册成功"] hideAnimated:YES afterDelay:kTimeIntervalShort];
            NSLog(@"response2:%@",response);
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _line2.hidden = true;
    _isLogin = true;
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
