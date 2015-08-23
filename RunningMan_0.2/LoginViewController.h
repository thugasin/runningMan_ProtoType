//
//  ViewController.h
//  RunningMan_0.2
//
//  Created by Sirius on 15/6/23.
//  Copyright (c) 2015年 Sirius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IObserver.h"


@interface LoginViewController : UIViewController<IObserver>

-(IBAction)SMSRegButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *UserId;
@property (strong, nonatomic) IBOutlet UITextField *Password;
- (IBAction)OnLogin:(id)sender;

@end
