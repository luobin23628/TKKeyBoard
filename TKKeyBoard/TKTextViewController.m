
//
//  TKTextFieldViewController.m
//  TKKeyBoard
//
//  Created by luobin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKTextViewController.h"
#import "TKKeyboard.h"

@interface TKTextViewController ()<UITextViewDelegate>

@property (nonatomic, retain) UITextView *textView;

@end

@implementation TKTextViewController

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
    
    self.textView = [[[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 100)] autorelease];
    self.textView.keyboardType = TKKeyboardTypeUIntegerPad;
    self.textView.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
    self.textView.delegate = self;
    self.textView.text = @"binGe Demo";
    [self.view addSubview:self.textView];
}

- (void)dealloc {
    self.textView = nil;
    [super dealloc];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"%s", __FUNCTION__);
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    NSLog(@"%s", __FUNCTION__);
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

@end
