//
//  TKKeyboardManager.m
//  TKKeyBoard
//
//  Created by luobin on 14-7-31.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKKeyboardManager.h"
#import "TKKeyboard.h"

@interface TKKeyboardManager ()

@property (nonatomic, retain) NSMutableDictionary *keyboards;

@end

@implementation TKKeyboardManager

+ (instancetype)shareInstance {
    static TKKeyboardManager *shareInstance = nil;
    if (!shareInstance) {
        @synchronized(self) {
            if (!shareInstance) {
                shareInstance = [[TKKeyboardManager alloc] init];
                [self initDefaultKeyboard];
            }
        }
    }
    return shareInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.keyboards = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc {
    self.keyboards = nil;
    [super dealloc];
}

- (void)registerKeyboardConfiguration:(TKKeyboardConfiguration *)configuration {
//    NSAssert([keyboardClass isSubclassOfClass:TKKeyboard.class], @"keyboardClass:%@ must be subclass of class TKKeyboard", keyboardClass);
    [self.keyboards setObject:configuration forKey:@(configuration.keyboardType)];
}

- (TKKeyboardConfiguration *)configurationForKeyboardType:(NSInteger)keyboardType {
    TKKeyboardConfiguration *configuration = [self.keyboards objectForKey:@(keyboardType)];
    return configuration;
}

#pragma mark - Private

+ (void)initDefaultKeyboard {
    TKKeyboardConfiguration *configiration = [[TKKeyboardConfiguration alloc] init];
    configiration.keyboardType = TKKeyboardTypeHexPad;
    configiration.keyboardSize = CGSizeMake(320, 216);
    
    NSMutableArray *keyItems = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        TKKeyItem *keyItem = [[TKKeyItem alloc] initWithTitle:[NSString stringWithFormat:@"%d", i] action:^(id<UITextInput> textInput) {
            [textInput insertText:[NSString stringWithFormat:@"%d", i + 1]];
        }];
        [keyItems addObject:keyItem];
        [keyItem release];
    }
    
    TKKeyItem *keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypeBackspace action:nil];
    [keyItems addObject:keyItem];
    [keyItem release];
    
     keyItem = [[TKKeyItem alloc] initWithTitle:@"0" action:^(id<UITextInput> textInput) {
        [textInput insertText:@"0"];
    }];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypeDelete action:^(id<UITextInput> textInput) {
        [textInput deleteBackward];
    }];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    configiration.keyItems = keyItems;
    [[TKKeyboardManager shareInstance] registerKeyboardConfiguration:configiration];
}

@end
