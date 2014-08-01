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

@interface TKMasterViewController () {
    
}

@property (nonatomic, retain) UITextField *textField;

@end

@implementation TKMasterViewController

- (void)dealloc {
    self.textField = nil;
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
    self.textField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 0, 280, 44)] autorelease];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.keyboardType = TKKeyboardTypeHexPad;
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        [cell addSubview:self.textField];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
