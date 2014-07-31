//
//  UIButton+Keyboard.m
//  TKKeyBoard
//
//  Created by luobin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "UIButton+Keyboard.h"

@implementation UIButton (Keyboard)

+ (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    
    [button setTitleColor:[UIColor colorWithWhite:24/255.0 alpha:1] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:24/255.0 alpha:1] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [button.titleLabel setShadowOffset:CGSizeMake(0, -0.5)];
    return button;
}

+ (UIButton *)buttonWithImage:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)backspaceButton {
    UIButton *button = [UIButton buttonWithImage:[UIImage imageNamed:@"backspace.png"]];
    return button;
}

@end
