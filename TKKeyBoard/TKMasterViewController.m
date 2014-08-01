//
//  TKMasterViewController.m
//  TKKeyBoard
//
//  Created by luobin on 14-7-31.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKMasterViewController.h"
#import "TKKeyboard.h"
#import "TKKeyboardManager.h"
#import "TKTextFieldViewController.h"
#import "TKTextViewController.h"

@interface TKMasterViewController () {
    
}


@end

@implementation TKMasterViewController

- (void)dealloc {
    [super dealloc];
}

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [TKKeyboardManager shareInstance];
    [[TKKeyboard alloc] init];
    [super viewDidLoad];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"UITextField";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"UITextView";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        TKTextFieldViewController *textFieldViewController = [[TKTextFieldViewController alloc] init];
        [self.navigationController pushViewController:textFieldViewController animated:YES];
        [textFieldViewController release];
    } else if (indexPath.row == 1) {
        TKTextViewController *textViewController = [[TKTextViewController alloc] init];
        [self.navigationController pushViewController:textViewController animated:YES];
        [textViewController release];
    }
}

@end
