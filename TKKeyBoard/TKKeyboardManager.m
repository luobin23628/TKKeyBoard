//
//  TKKeyboardManager.m
//  TKKeyBoard
//
//  Created by luobin on 14-7-31.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKKeyboardManager.h"
#import "TKKeyboard.h"
#import "TKGridLayout.h"

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
                [self initIntegerKeyboard];
                [self initUIntegerKeyboard];
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

+ (void)initIntegerKeyboard {
    [self doInitIntegerKeyboard:NO];
}

+ (void)initUIntegerKeyboard {
    [self doInitIntegerKeyboard:YES];
}

+ (void)doInitIntegerKeyboard:(BOOL)isUnsigned {
    TKKeyboardConfiguration *configiration = [[TKKeyboardConfiguration alloc] init];
    if (isUnsigned) {
        configiration.keyboardType = TKKeyboardTypeUIntegerPad;
    } else {
        configiration.keyboardType = TKKeyboardTypeIntegerPad;
    }
    configiration.keyboardHeight = 216;
    
    TKGridLayout *layout = [[TKGridLayout alloc] init];
    layout.rowCount = 4;
    layout.columnCount = 3;
    configiration.layout = layout;
    [layout release];
    
    NSMutableArray *keyItems = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        TKKeyItem *keyItem = [[TKKeyItem alloc] initWithInsertText:[NSString stringWithFormat:@"%d", i]];
        keyItem.highlightBackgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
        [keyItems addObject:keyItem];
        [keyItem release];
    }
    
    TKKeyItem *keyItem;
    if (isUnsigned) {
        TKKeyItem *keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypeBackspace action:nil];
        keyItem.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
        keyItem.highlightBackgroundColor = [UIColor colorWithWhite:251/255.0 alpha:1];
        keyItem.enable = NO;
        [keyItems addObject:keyItem];
        [keyItem release];

    } else {
        keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypePositiveOrNegative action:^(id<TKTextInput> textInput) {
            [textInput positiveOrNegative];
        }];
        keyItem.highlightBackgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
        [keyItems addObject:keyItem];
        [keyItem release];
    }

    keyItem = [[TKKeyItem alloc] initWithInsertText:@"0"];
    keyItem.highlightBackgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypeDelete action:^(id<TKTextInput> textInput) {
        [textInput deleteBackward];
    }];
    keyItem.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
    keyItem.highlightBackgroundColor = [UIColor colorWithWhite:251/255.0 alpha:1];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    configiration.keyItems = keyItems;
    [[TKKeyboardManager shareInstance] registerKeyboardConfiguration:configiration];
}

@end
