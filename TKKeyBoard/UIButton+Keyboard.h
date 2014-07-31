//
//  UIButton+Keyboard.h
//  TKKeyBoard
//
//  Created by luobin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Keyboard)

+ (UIButton *)buttonWithTitle:(NSString *)title;

+ (UIButton *)buttonWithImage:(UIImage *)image;

+ (UIButton *)backspaceButton;

@end
