//
//  PacManLoginViewController.h
//  RunningManDemo
//
//  Created by Sirius on 15-4-6.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface PacManLoginViewController : UIViewController
{
    
}

@property(nonatomic, assign) IBOutlet UITextField* phoneNumber;
@property(nonatomic, assign) IBOutlet UITextField* ServerIP;
@property(nonatomic, retain) LocationDemoViewController* locationViewController;

-(IBAction)Login:(id)sender;
- (IBAction)hidKeyBoard:(id)sender;
@end
