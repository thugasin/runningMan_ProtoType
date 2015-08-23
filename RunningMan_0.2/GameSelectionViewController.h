//
//  GameSelectionViewController.h
//  RunningMan_0.2
//
//  Created by Sirius on 15/7/4.
//  Copyright (c) 2015年 Sirius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSelectionViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *list;

@end
