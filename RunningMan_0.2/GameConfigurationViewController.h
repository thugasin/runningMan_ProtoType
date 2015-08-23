//
//  GameConfigurationViewController.h
//  RunningManDemo
//
//  Created by Sirius on 15-6-5.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameConfigurationViewController : UIViewController
{
    NSArray *pickerArray;
}

-(IBAction)ShowGameSelection:(id)sender;
-(IBAction)DisplayGameSelection:(id)sender;


@property (strong, nonatomic) IBOutlet UIPickerView *GamePicker;
@property (strong, nonatomic) IBOutlet UITextField *GameText;
@property (strong, nonatomic) IBOutlet UIToolbar *DoneToolBar;
@end
