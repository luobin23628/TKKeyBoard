//
//  TKMasterViewController.h
//  TKKeyBoard
//
//  Created by luobin on 14-7-31.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKDetailViewController;

@interface TKMasterViewController : UITableViewController

@property (strong, nonatomic) TKDetailViewController *detailViewController;

@end
