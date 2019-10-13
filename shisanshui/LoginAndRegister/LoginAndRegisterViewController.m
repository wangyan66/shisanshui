//
//  LoginAndRegisterViewController.m
//  shisanshui
//
//  Created by 王焱 on 2019/10/13.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#import "ZWAPIRequestTool.h"
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
    if (_isLogin) {
        [ZWAPIRequestTool requestLoginWithPhoneNumber:self.UserNameTextField.text password:self.PasswordTextField.text result:^(id response, BOOL success) {
            NSLog(@"response1:%@",response);
        }];
    }else{
        [ZWAPIRequestTool requestRegisterWithPhoneNumber:self.UserNameTextField.text password:self.PasswordTextField.text result:^(id response, BOOL success) {
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
