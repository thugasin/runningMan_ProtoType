//
//  RegisterViewController.m
//  RunningMan_0.2
//
//  Created by Sirius on 15/6/26.
//  Copyright (c) 2015年 Sirius. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize Password;
@synthesize PhoneNumber;
@synthesize ConfirmedPassword;
@synthesize BtConfirmRegister;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
    
    Password.placeholder = @"请输入密码";
    Password.secureTextEntry = YES;
    
    ConfirmedPassword.placeholder = @"请再次输入密码";
    ConfirmedPassword.secureTextEntry = YES;
    
    PhoneNumber.placeholder = @"电话";
    
    
    [BtConfirmRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    BtConfirmRegister.layer.cornerRadius = 10.0;
    BtConfirmRegister.backgroundColor = [UIColor blueColor];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)OnRegisterButtonClicked:(id)sender {
    
}
@end
