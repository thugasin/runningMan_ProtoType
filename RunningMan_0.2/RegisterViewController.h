//
//  RegisterViewController.h
//  RunningMan_0.2
//
//  Created by Sirius on 15/6/26.
//  Copyright (c) 2015年 Sirius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
{
    
}
@property (strong, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *Password;
@property (strong, nonatomic) IBOutlet UITextField *ConfirmedPassword;
@property (strong, nonatomic) IBOutlet UIButton *BtConfirmRegister;

- (IBAction)OnRegisterButtonClicked:(id)sender;

@end
