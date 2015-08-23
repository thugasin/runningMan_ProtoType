//
//  GameConfigurationViewController.m
//  RunningManDemo
//
//  Created by Sirius on 15-6-5.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "GameConfigurationViewController.h"
@implementation GameConfigurationViewController

@synthesize GamePicker;
@synthesize GameText;
@synthesize DoneToolBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    pickerArray = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:@"吃豆子",@"夺旗",@"夺宝奇兵",@"谁是杀手", nil]];
    //pickerArray = [NSArray arrayWithObjects:@"动物",@"植物",@"石头",@"天空", nil];
    self.GameText.inputView = GamePicker;
    self.GameText.inputAccessoryView = DoneToolBar;
    self.GameText.delegate = self;
    self.GamePicker.delegate = self;
    self.GamePicker.dataSource = self;
    self.GamePicker.frame = CGRectMake(0, 480, 320, 216);
    GamePicker.hidden = true;
}

-(IBAction)ShowGameSelection:(id)sender
{
    GamePicker.hidden = false;
}

-(IBAction)DisplayGameSelection:(id)sender
{
    NSInteger row = [self.GamePicker selectedRowInComponent:0];
    GameText.text = [pickerArray objectAtIndex:row];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger row = [self.GamePicker selectedRowInComponent:0];
    GameText.text = [pickerArray objectAtIndex:row];
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [GameText resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
