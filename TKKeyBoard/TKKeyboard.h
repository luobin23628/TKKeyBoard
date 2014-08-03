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
    TKKeyboardTypeHexPad,
    TKKeyboardTypeUnsignedHexPad,
    TKKeyboardTypeFloatPad,
    TKKeyboardTypeUnsignedFloatPad,
};

@protocol TKTextInput<UITextInput>

- (UIResponder *)firstResponder;
- (BOOL)isEmpty;
- (void)clear;
- (void)returnKey;
- (void)positiveOrNegative;

@end

@interface TKKeyboard : UIView<UIInputViewAudioFeedback>

- (id)initWithConfiguration:(TKKeyboardConfiguration *)configuration;

@property (nonatomic, readonly) id<UITextInput> textInput;

@end
