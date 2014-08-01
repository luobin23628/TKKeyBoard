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

@interface TKKeyboard ()

@property (nonatomic, readwrite, assign) id<UITextInput> textInput;

@property (nonatomic, retain) TKKeyboardConfiguration *configuration;
@property (nonatomic, retain) NSArray *keyButtons;
@property (nonatomic, retain) TKLayout *layout;
@property (nonatomic, retain) UIView *container;

@end

@implementation TKKeyboard

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
        
        self.container = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
        self.container.backgroundColor = [UIColor clearColor];
        self.container.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.container];
        
        NSMutableArray *keyButtons = [NSMutableArray array];
        for (TKKeyItem *item in self.configuration.keyItems) {
            TKKeyButton *keyBtn = [TKKeyButton buttonWithItem:item];
            [keyBtn addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.container addSubview:keyBtn];
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
    self.container = nil;
    self.layout = nil;
    self.keyButtons = nil;
    self.configuration = nil;
    self.textInput = nil;
    [super dealloc];
}

- (void)touchUpInsideAction:(TKKeyButton *)keyBtn {
    if (keyBtn.item.action) {
        keyBtn.item.action((id<TKTextInput>)self);
    }
}

- (void)setTextInput:(id<UITextInput>)textInput {
    _textInput = textInput;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.layout layoutSubviews:self.keyButtons forView:self.container];
}

#pragma mark - Private

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
    NSInteger startPos = [textInput offsetFromPosition:textInput.beginningOfDocument
                                      toPosition:textRange.start];
    NSInteger length = [textInput offsetFromPosition:textRange.start
                                    toPosition:textRange.end];
    NSRange selectedRange = NSMakeRange(startPos, length);
    if ([self textInput:textInput shouldChangeCharactersInRange:selectedRange withString:string]) {
        [textInput replaceRange:textRange withText:string];
    }
}

- (UITextRange *)textRangeFromTextRange:(UITextRange *)textRange offset:(NSInteger)offset {
    UITextPosition *startPos = [self.textInput positionFromPosition:textRange.start offset:offset];
    UITextPosition * endPost = [self.textInput positionFromPosition:textRange.end offset:offset];
    return [self.textInput textRangeFromPosition:startPos toPosition:endPost];
}

#pragma mark - TKKeyInput

- (void)insertText:(NSString *)text {
    UITextRange *textRange = [self.textInput selectedTextRange];
    [self textInput:self.textInput replaceTextAtTextRange:textRange withString:text];
}

- (void)deleteBackward {
    UITextRange *selectedTextRange = self.textInput.selectedTextRange;
    UITextPosition  *startPosition = [self.textInput positionFromPosition:selectedTextRange.start offset:-1];
    if (!startPosition) {
        return;
    }
    UITextPosition *endPosition = selectedTextRange.end;
    if (!endPosition) {
        return;
    }
    UITextRange *rangeToDelete = [self.textInput textRangeFromPosition:startPosition toPosition:endPosition];
    [self textInput:self.textInput replaceTextAtTextRange:rangeToDelete withString:@""];
}

- (void)replaceRange:(UITextRange *)range withText:(NSString *)text {
    [self textInput:self.textInput replaceTextAtTextRange:range withString:text];
}

- (void)clear {
    UITextPosition *startPos = self.textInput.beginningOfDocument;
    UITextPosition *endPost = self.textInput.endOfDocument;
    UITextRange *allTextRange = [self.textInput textRangeFromPosition:startPos
                                                           toPosition:endPost];
    if (!allTextRange.isEmpty) {
        if ([self.textInput isKindOfClass:[UITextField class]]) {
            id<UITextFieldDelegate> delegate = [(UITextField *)self.textInput delegate];
            if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
                if (![delegate textFieldShouldClear:(UITextField *)self.textInput]) {
                    return;
                };
            }
        }
        [self.textInput replaceRange:allTextRange withText:@""];
    }
}

- (void)keyReturn {
    if ([self.textInput isKindOfClass:[UITextField class]]) {
        id<UITextFieldDelegate> delegate = [(UITextField *)self.textInput delegate];
        if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
            [delegate textFieldShouldReturn:(UITextField *)self.textInput];
        }
    } else if ([self.textInput isKindOfClass:[UITextView class]]) {
        [self insertText:@"\n"];
    }
}

- (void)positiveOrNegative {
    UITextRange *selectedTextRange = self.textInput.selectedTextRange;
    
    UITextPosition *startPos = self.textInput.beginningOfDocument;
    if (!startPos) {
        [self textInput:self.textInput replaceTextAtTextRange:self.textInput.selectedTextRange withString:@"-"];
        return;
    }
    
    UITextPosition *endPost = [self.textInput positionFromPosition:startPos offset:1];
    if (!endPost) {
        [self textInput:self.textInput replaceTextAtTextRange:self.textInput.selectedTextRange withString:@"-"];
        return;
    }
    
    UITextRange *firstCharactorRange = [self.textInput textRangeFromPosition:startPos toPosition:endPost];
    NSString *firstCharactor = [self.textInput textInRange:firstCharactorRange];
    if ([firstCharactor isEqualToString:@"-"]) {
        [self textInput:self.textInput replaceTextAtTextRange:firstCharactorRange withString:@""];
        
        selectedTextRange = [self textRangeFromTextRange:selectedTextRange offset:-1];
    } else {
        firstCharactorRange = [self.textInput textRangeFromPosition:startPos toPosition:startPos];
        [self textInput:self.textInput replaceTextAtTextRange:firstCharactorRange withString:@"-"];
        
        selectedTextRange = [self textRangeFromTextRange:selectedTextRange offset:1];
    }
    self.textInput.selectedTextRange = selectedTextRange;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (self.textInput && [self.textInput respondsToSelector:aSelector]) {
        return self.textInput;
    }
    return [super forwardingTargetForSelector:aSelector];
}

-(NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector;
{
	if([super respondsToSelector:aSelector]) return [super methodSignatureForSelector:aSelector];
	if([self.textInput respondsToSelector:aSelector]) return [(id)self.textInput methodSignatureForSelector:aSelector];
	return nil;
}

-(BOOL)respondsToSelector:(SEL)aSelector;
{
	return [super respondsToSelector:aSelector] || [self.textInput respondsToSelector:aSelector];
}

@end


@interface UIResponder(TKKeyboard)
@end

@interface UITextField(TKKeyboard)
@end

@interface UITextView(TKKeyboard)
@end

@implementation UIResponder(TKKeyboard)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIResponder swizzleMethod:@selector(inputView) withMethod:@selector(replacedInputView)];
    });
}

- (UIView *)replacedInputView {
    if ([self conformsToProtocol:@protocol(UITextInput)]) {
        UIResponder<UITextInput> *textInputView = (UIResponder<UITextInput> *)self;
        TKKeyboardConfiguration *configuration = [[TKKeyboardManager shareInstance] configurationForKeyboardType:textInputView.keyboardType];
        if (configuration) {
            TKKeyboard *keyboard = [[TKKeyboard alloc] initWithConfiguration:configuration];
            [keyboard setTextInput:textInputView];
            return [keyboard autorelease];
        }
    }
    UIView *inputView = [self replacedInputView];
    return inputView;
}

@end

@implementation UITextField(TKKeyboard)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UITextField swizzleMethod:@selector(inputView) withMethod:@selector(replacedInputView)];
    });
}

- (UIView *)replacedInputView {
    TKKeyboardConfiguration *configuration = [[TKKeyboardManager shareInstance] configurationForKeyboardType:self.keyboardType];
    if (configuration) {
        return [super inputView];
    }
    UIView *inputView = [self replacedInputView];
    return inputView;
}

@end

@implementation UITextView(TKKeyboard)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UITextView swizzleMethod:@selector(inputView) withMethod:@selector(replacedInputView)];
    });
}

- (UIView *)replacedInputView {
    TKKeyboardConfiguration *configuration = [[TKKeyboardManager shareInstance] configurationForKeyboardType:self.keyboardType];
    if (configuration) {
        return [super inputView];
    }
    UIView *inputView = [self replacedInputView];
    return inputView;
}

@end
