//
//  TKKeyButton.m
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKKeyButton.h"

@interface TKKeyButton()

@property (nonatomic, readwrite, retain) TKKeyItem *item;

@end

@implementation TKKeyButton

- (void)dealloc {
    self.item = nil;
    [super dealloc];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = (CGRect){.size = {1, 1}};
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (TKKeyButton *)buttonWithItem:(TKKeyItem *)item {
    TKKeyButton *button = nil;
    if (item.customView) {
        button = [TKKeyButton buttonWithCustomView:item.customView];
    } else if (item.image) {
        button = [self buttonWithImage:item.image];
    } else {
        button = [self buttonWithTitle:item.title?:@""];
        if (item.titleFont) {
            button.titleLabel.font = item.titleFont;
        }
        if (item.titleColor) {
            [button setTitleColor:item.titleColor forState:UIControlStateNormal];
        }
        if (item.highlightTitleColor) {
            [button setTitleColor:item.highlightTitleColor forState:UIControlStateHighlighted];
        }
    }
    
    if (item.backgroundColor) {
        [button setBackgroundImage:[self imageWithColor:item.backgroundColor] forState:UIControlStateNormal];
    }
    if (item.highlightBackgroundColor) {
        [button setBackgroundImage:[self imageWithColor:item.highlightBackgroundColor] forState:UIControlStateHighlighted];
    }
    
    button.adjustsImageWhenDisabled = NO;
    button.enabled = item.enable;
    
    button.item = item;
    return button;
}

+ (TKKeyButton *)buttonWithCustomView:(UIView *)customView {
    TKKeyButton *button = [TKKeyButton buttonWithType:UIButtonTypeCustom];
    customView.frame = button.bounds;
    customView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [button addSubview:customView];
    return button;
}

+ (TKKeyButton *)buttonWithTitle:(NSString *)title {
    TKKeyButton *button = [TKKeyButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:24.0]];
    
    [button setTitleColor:[UIColor colorWithWhite:24/255.0 alpha:1] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:24/255.0 alpha:1] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [button.titleLabel setShadowOffset:CGSizeMake(0, -0.5)];
    return button;
}

+ (TKKeyButton *)buttonWithImage:(UIImage *)image {
    TKKeyButton *button = [TKKeyButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

@end
