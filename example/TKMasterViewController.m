//
//  TKMasterViewController.m
//  TKKeyBoard
//
//  Created by luobin on 14-7-31.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKMasterViewController.h"
#import "TKTextFieldViewController.h"
#import "TKTextViewController.h"
#import "TKKeyboard.h"

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
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        if ([self respondsToSelector:@selector(setPreferredContentSize:)]) {
            self.preferredContentSize = CGSizeMake(320.0, 600.0);
        }
#endif
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"TKKeyboardTypeIntegerPad";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"TKKeyboardTypeHexPad";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"TKKeyboardTypeFloatPad";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger keyboardType = TKKeyboardTypeIntegerPad;
    if (indexPath.row == 0) {
        keyboardType = TKKeyboardTypeIntegerPad;
    } else if (indexPath.row == 1) {
        keyboardType = TKKeyboardTypeHexPad;
    } else if (indexPath.row == 2) {
        keyboardType = TKKeyboardTypeUnsignedFloatPad;
    }
    TKTextFieldViewController *textFieldViewController = [[TKTextFieldViewController alloc] initWithKeyboardType:keyboardType];
    [self.navigationController pushViewController:textFieldViewController animated:YES];
    [textFieldViewController release];
}

@end
