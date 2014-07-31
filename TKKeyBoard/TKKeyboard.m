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

@interface TKKeyboard ()

@property (nonatomic, retain) TKKeyboardConfiguration *configuration;

@end

@implementation TKKeyboard

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIResponder swizzleMethod:@selector(inputView) withMethod:@selector(replacedInputView)];
    });
}

- (id)initWithConfiguration:(TKKeyboardConfiguration *)configuration {
    CGSize keyboardSize = configuration.keyboardSize;
    self = [super initWithFrame:CGRectMake(0, 0, keyboardSize.width, keyboardSize.height)];
    if (self) {
        // Initialization code
        self.configuration = configuration;
    }
    return self;
}

- (void)dealloc {
    self.configuration = nil;
    self.textInput = nil;
    [super dealloc];
}

- (void)setTextInput:(id<UITextInput>)textInput {
    _textInput = textInput;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
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
