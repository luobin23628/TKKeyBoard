//
//  TKKeyboard.m
//  TKKeyBoard
//
//  Created by luobin on 14-7-31.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKKeyboard.h"
#import "NSObject+Swizzle.h"
#import "TKKeyboardManager.h"
#import "TKKeyButton.h"
#import "TKGridLayout.h"

@interface UIResponder(Keyboard)

@end

@implementation UIResponder(Keyboard)

- (UIView *)replacedInputView {
    if ([self conformsToProtocol:@protocol(UITextInput)]) {
        UIResponder<UITextInput> *textInputView = (UIResponder<UITextInput> *)self;
        TKKeyboardConfiguration *configuration = [[TKKeyboardManager shareInstance] configurationForKeyboardType:textInputView.keyboardType];
        if (configuration) {
            TKKeyboard *keyboard = [[TKKeyboard alloc] initWithConfiguration:configuration];
            return [keyboard autorelease];
        }
    }
    UIView *inputView = [self replacedInputView];
    return inputView;
}

@end

@interface UITextField(Keyboard)

@end

@implementation UITextField(Keyboard)

- (UIView *)replacedInputView {
    TKKeyboardConfiguration *configuration = [[TKKeyboardManager shareInstance] configurationForKeyboardType:self.keyboardType];
    if (configuration) {
        TKKeyboard *keyboard = [[TKKeyboard alloc] initWithConfiguration:configuration];
        [keyboard setTextInput:self];
        return [keyboard autorelease];
    }
    UIView *inputView = [self replacedInputView];
    return inputView;
}

@end

@interface TKKeyboard ()

@property (nonatomic, retain) TKKeyboardConfiguration *configuration;
@property (nonatomic, retain) NSArray *keyButtons;
@property (nonatomic, retain) TKLayout *layout;

@end

@implementation TKKeyboard

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIResponder swizzleMethod:@selector(inputView) withMethod:@selector(replacedInputView)];
        [UITextField swizzleMethod:@selector(inputView) withMethod:@selector(replacedInputView)];
    });
}

- (id)initWithConfiguration:(TKKeyboardConfiguration *)configuration {
    CGSize keyboardSize = configuration.keyboardSize;
    self = [super initWithFrame:CGRectMake(0, 0, keyboardSize.width, keyboardSize.height)];
    if (self) {
        // Initialization code
        self.configuration = configuration;
        
        UIColor *backgroundColor = self.configuration.backgroundColor;
        if (!backgroundColor) {
            backgroundColor = [UIColor colorWithWhite:251/255.0 alpha:1];
        }
        self.backgroundColor = backgroundColor;
        
        NSMutableArray *keyButtons = [NSMutableArray array];
        for (TKKeyItem *item in self.configuration.keyItems) {
            TKKeyButton *keyBtn = [TKKeyButton buttonWithItem:item];
            [keyBtn addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:keyBtn];
            [keyButtons addObject:keyBtn];
        }
        self.keyButtons = keyButtons;
        
        TKLayout *layout = self.configuration.layout;
        if (!layout) {
            TKGridLayout *gridLayout = [[[TKGridLayout alloc] init] autorelease];
            gridLayout.columnCount = 3;
            layout = gridLayout;
        }
        self.layout = layout;
    }
    return self;
}

- (void)dealloc {
    self.keyButtons = nil;
    self.configuration = nil;
    self.textInput = nil;
    [super dealloc];
}

- (void)touchUpInsideAction:(TKKeyButton *)keyBtn {
    if (keyBtn.item.action) {
        keyBtn.item.action(_textInput);
    }
}

- (void)setTextInput:(id<UITextInput>)textInput {
    _textInput = textInput;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.layout layoutSubviews:self.keyButtons forView:self];
}

- (BOOL)textInput:(id <UITextInput>)textInput shouldChangeCharactersInRange:(NSRange)range withString:(NSString *)string
{
    if ([textInput isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)textInput;
        if ([textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            if (![textField.delegate textField:textField
                 shouldChangeCharactersInRange:range
                             replacementString:string]) {
                return NO;
            }
        }
    } else if ([textInput isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)textInput;
        if ([textView.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
            if (![textView.delegate textView:textView
                     shouldChangeTextInRange:range
                             replacementText:string]) {
                return NO;
            }
        }
    }
    return YES;
}

- (void)textInput:(id <UITextInput>)textInput replaceTextAtTextRange:(UITextRange *)textRange withString:(NSString *)string {
    int startPos = [textInput offsetFromPosition:textInput.beginningOfDocument
                                      toPosition:textRange.start];
    int length = [textInput offsetFromPosition:textRange.start
                                    toPosition:textRange.end];
    NSRange selectedRange = NSMakeRange(startPos, length);
    if ([self textInput:textInput shouldChangeCharactersInRange:selectedRange withString:string]) {
        [textInput replaceRange:textRange withText:string];
    }
}

@end
