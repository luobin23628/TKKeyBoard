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
    TKKeyboardTypeIntegerPad = 100,
    TKKeyboardTypeUIntegerPad,
    TKKeyboardTypeFloatPad,
    TKKeyboardTypeHexPad
};

@protocol TKTextInput<UITextInput>

- (UIResponder *)firstResponder;
- (BOOL)isEmpty;
- (void)clear;
- (void)keyReturn;
- (void)positiveOrNegative;

@end

@interface TKKeyboard : UIView<UIInputViewAudioFeedback>

- (id)initWithConfiguration:(TKKeyboardConfiguration *)configuration;

@property (nonatomic, readonly) id<UITextInput> textInput;

@end
