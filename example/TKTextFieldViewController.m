
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
@property (nonatomic, assign) NSInteger keyboardType;

@end

@implementation TKTextFieldViewController

- (id)initWithKeyboardType:(NSInteger)keyboardType;
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = @"UITextField Demo";
        self.keyboardType = keyboardType;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000  
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
#endif
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 70, 280, 44)] autorelease];
    self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.font = [UIFont systemFontOfSize:20];
    self.textField.keyboardType = self.keyboardType;
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
