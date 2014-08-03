//
//  TKTextFieldViewController.h
//  TKKeyBoard
//
//  Created by luobin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKTextFieldViewController : UIViewController

- (id)initWithKeyboardType:(NSInteger)keyboardType;

@property (nonatomic, readonly, retain) UITextField *textField;

@end
