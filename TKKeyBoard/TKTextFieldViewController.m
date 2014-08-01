
//
//  TKTextFieldViewController.m
//  TKKeyBoard
//
//  Created by luobin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKTextFieldViewController.h"
#import "TKKeyboard.h"

@interface TKTextFieldViewController ()<UITextFieldDelegate>

@property (nonatomic, retain) UITextField *textField;

@end

@implementation TKTextFieldViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"UITextField Demo";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 100, 280, 44)] autorelease];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.keyboardType = TKKeyboardTypeIntegerPad;
    
    self.textField.delegate = self;
    self.textField.text = @"binGe Demo";
    self.textField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:self.textField];
}

- (void)dealloc {
    self.textField = nil;
    [super dealloc];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

@end
