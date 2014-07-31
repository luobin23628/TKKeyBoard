//
//  TKKeyboard.h
//  TKKeyBoard
//
//  Created by luobin on 14-7-31.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKKeyboardConfiguration.h"

typedef NS_ENUM(NSInteger, TKKeyboardType) {
    TKKeyboardTypeIntegerPad = 999,
    TKKeyboardTypeFloatPad,
    TKKeyboardTypeHexPad
};

@interface TKKeyboard : UIView

- (id)initWithConfiguration:(TKKeyboardConfiguration *)configuration;

@property (nonatomic, assign) id<UITextInput> textInput;

@end
