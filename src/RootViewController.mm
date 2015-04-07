//
//  ViewController.m
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-3-21.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "RootViewController.h"
#import "BMKVersion.h"
#import "PacManLoginViewController.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _demoNameArray = [[NSArray alloc]initWithObjects:
					  @"开启吃豆人",
					  nil];
    _viewControllerTitleArray = [[NSArray alloc]initWithObjects:
                                 @"吃豆人",
                                 nil];
    
    _viewControllerArray = [[NSArray alloc]initWithObjects:
                            @"PacManLoginViewController",
                            nil];
	self.title = @"RunningMan Demo";
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
}

#pragma mark -
#pragma mark Table view data source


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _demoNameArray.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"BaiduMapApiDemoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_demoNameArray objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController* viewController = [[NSClassFromString([_viewControllerArray objectAtIndex:indexPath.row]) alloc] init];
    viewController.title = [_viewControllerTitleArray objectAtIndex:indexPath.row];
    UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init];
//    customLeftBarButtonItem.title = @"返回";
//    self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
    [self.navigationController pushViewController:viewController animated:YES];

}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

@end
