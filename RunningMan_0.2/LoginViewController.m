//
//  ViewController.m
//  RunningMan_0.2
//
//  Created by Sirius on 15/6/23.
//  Copyright (c) 2015年 Sirius. All rights reserved.
//

#import "LoginViewController.h"
#import "RegViewController.h"
#import "NetworkAdapter.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize Password;
@synthesize UserId;

- (void)viewDidLoad {
    [super viewDidLoad];
    Password.placeholder = @"密码";
    UserId.placeholder = @"用户名／手机号／邮箱号";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(IBAction)SMSRegButtonClick:(id)sender
{
    RegViewController* reg=[[RegViewController alloc] init];
    [self presentViewController:reg animated:YES completion:^{
        
    }];}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)OnLogin:(id)sender {
    NetworkAdapter *na = [NetworkAdapter InitNetwork];
   // BOOL result = [na Connect:@"100.96.141.155" Port:9090];
    BOOL result = [na Connect:@"ayo.org.cn" Port:9090];
    
    [na SubscribeMessage:LOGIN_RESULT Instance:self];
    
    if (result) {
        NSString * command = @"login 2\r\n";
        NSString * sUserID = [NSString stringWithFormat:@"%@\r\n", UserId.text];
        NSString * sPassword = [NSString stringWithFormat:@"%@\r\n", Password.text];
        
        NSString * LogingMessage = [NSString stringWithFormat:@"%@%@%@", command, sUserID, sPassword];
        
        [na sendData:LogingMessage];
    }
}

-(void) ONMessageCome:(NSString *)MsgBody
{
    NSLog(@"hahaha");
}


@end
