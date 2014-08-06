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
#import "TKFlowLayout.h"

//修正f为最接近的0.5的倍数
static double fix(double f){
    double f1 = ceil(f);
    double f2 = floor(f);
    double f3 = (f1 + f2)/2;
    
    double fabs1 = fabs(f - f1);
    double fabs2 = fabs(f - f2);
    double fabs3 = fabs(f - f3);
    
    if (fabs1 < fabs2) {
        if (fabs1 < fabs3) {
            return f1;
        } else {
            return f3;
        }
    } else {
        if (fabs2 < fabs3) {
            return f2;
        } else {
            return f3;
        }
    }
}

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
                [self initHexKeyboard];
                [self initUnsignedHexKeyboard];
                [self initFloatKeyboard];
                [self initUnsignedFloatKeyboard];
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
    NSAssert([self.keyboards objectForKey:@(configuration.keyboardType)] == nil, @"Keyboard type:%d has exist.", configuration.keyboardType);
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
    configiration.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
    
    TKGridLayout *layout = [[TKGridLayout alloc] init];
    layout.rowCount = 4;
    layout.columnCount = 3;
    configiration.layout = layout;
    [layout release];
    
    NSMutableArray *keyItems = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        TKKeyItem *keyItem = [[TKKeyItem alloc] initWithInsertText:[NSString stringWithFormat:@"%d", i]];
        [keyItems addObject:keyItem];
        [keyItem release];
    }
    
    TKKeyItem *keyItem;
    if (isUnsigned) {
        TKKeyItem *keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypeBackspace action:nil];
        keyItem.enable = NO;
        [keyItems addObject:keyItem];
        [keyItem release];
    } else {
        keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypePositiveOrNegative action:^(id<TKTextInput> textInput, TKKeyItem *keyItem) {
            [textInput positiveOrNegative];
        }];
        [keyItems addObject:keyItem];
        [keyItem release];
    }

    keyItem = [[TKKeyItem alloc] initWithInsertText:@"0"];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypeDelete action:^(id<TKTextInput> textInput, TKKeyItem *keyItem) {
        [textInput deleteBackward];
    }];
    keyItem.enablesAutomatically = NO;
    keyItem.enableLongPressRepeat = YES;
    keyItem.backgroundColor = [UIColor colorWithWhite:225/255.0 alpha:1];
    keyItem.highlightBackgroundColor = [UIColor colorWithWhite:251/255.0 alpha:1];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    configiration.keyItems = keyItems;
    [[TKKeyboardManager shareInstance] registerKeyboardConfiguration:configiration];
    [configiration release];
}

+ (void)initHexKeyboard {
    [self doInitHexKeyboard:NO];
}

+ (void)initUnsignedHexKeyboard {
    [self doInitHexKeyboard:YES];
}

+ (void)doInitHexKeyboard:(BOOL)isUnsigned {
    TKKeyboardConfiguration *configiration = [[TKKeyboardConfiguration alloc] init];
    if (isUnsigned) {
        configiration.keyboardType = TKKeyboardTypeUnsignedHexPad;
    } else {
        configiration.keyboardType = TKKeyboardTypeHexPad;
    }
    configiration.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
    
    NSMutableArray *keyItems = [NSMutableArray array];
    NSArray *keyNames = @[@"7", @"8", @"9", @"A", @"B",
                          @"4", @"5", @"6", @"C", @"D",
                          @"1", @"2", @"3", @"E", @"F"];
    for (int i = 0; i < [keyNames count]; i++) {
        TKKeyItem *keyItem = [[TKKeyItem alloc] initWithInsertText:[keyNames objectAtIndex:i]];
        [keyItems addObject:keyItem];
        [keyItem release];
    }
    
    TKKeyItem *keyItem;
    if (isUnsigned) {
        TKKeyItem *keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypeBackspace action:nil];
        keyItem.enable = NO;
        [keyItems addObject:keyItem];
        [keyItem release];
        
    } else {
        keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypePositiveOrNegative action:^(id<TKTextInput> textInput, TKKeyItem *keyItem) {
            [textInput positiveOrNegative];
        }];
        keyItem.highlightBackgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
        [keyItems addObject:keyItem];
        [keyItem release];
    }
    
    keyItem = [[TKKeyItem alloc] initWithInsertText:@"0"];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypeDelete action:^(id<TKTextInput> textInput, TKKeyItem *keyItem) {
        [textInput deleteBackward];
    }];
    keyItem.enableLongPressRepeat = YES;
//    keyItem.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
//    keyItem.highlightBackgroundColor = [UIColor colorWithWhite:251/255.0 alpha:1];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypeReturn action:^(id<TKTextInput> textInput, TKKeyItem *keyItem) {
        [textInput returnKey];
    }];
    keyItem.titleFont = [UIFont systemFontOfSize:20];
    keyItem.backgroundColor = [UIColor colorWithWhite:225/255.0 alpha:1];
    keyItem.highlightBackgroundColor = [UIColor colorWithWhite:251/255.0 alpha:1];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    configiration.keyItems = keyItems;
    
    TKFlowLayout *layout = [[TKFlowLayout alloc] initWithSizeForIndexBlock:^CGSize(NSUInteger index, TKFlowLayout *layout, CGRect inRect) {
        int row = 4, column = 5;
        
        CGFloat innerWidth = (inRect.size.width - layout.padding*2  - (column - 1) *layout.spacing);
        CGFloat innerHeight = (inRect.size.height - layout.padding*2 - (row - 1) *layout.spacing);
        CGFloat width = fix(innerWidth/column);
        CGFloat height = fix(innerHeight/row);
        if (index == keyItems.count - 1) {
            return CGSizeMake(width * 2, height);
        } else {
            return CGSizeMake(width, height);
        }
    }];
    configiration.layout = layout;
    [layout release];
    
    [[TKKeyboardManager shareInstance] registerKeyboardConfiguration:configiration];
    [configiration release];
}

+ (void)initFloatKeyboard {
    [self doInitFloatKeyboard:NO];
}

+ (void)initUnsignedFloatKeyboard {
    [self doInitFloatKeyboard:YES];
}

+ (void)doInitFloatKeyboard:(BOOL)isUnsigned {
    TKKeyboardConfiguration *configiration = [[TKKeyboardConfiguration alloc] init];
    if (isUnsigned) {
        configiration.keyboardType = TKKeyboardTypeUnsignedFloatPad;
    } else {
        configiration.keyboardType = TKKeyboardTypeFloatPad;
    }
    configiration.keyboardHeight = 216;
    configiration.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
    
    TKGridLayout *layout = [[TKGridLayout alloc] init];
    layout.rowCount = 4;
    layout.columnCount = 3;
    configiration.layout = layout;
    [layout release];
    
    NSMutableArray *keyItems = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        TKKeyItem *keyItem = [[TKKeyItem alloc] initWithInsertText:[NSString stringWithFormat:@"%d", i]];
        [keyItems addObject:keyItem];
        [keyItem release];
    }
    
    TKKeyItem *keyItem;
    if (isUnsigned) {
        TKKeyItem *keyItem = [[TKKeyItem alloc] initWithInsertText:@"."];
        [keyItems addObject:keyItem];
        [keyItem release];
    } else {
        keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypePositiveOrNegative action:^(id<TKTextInput> textInput, TKKeyItem *keyItem) {
            [textInput positiveOrNegative];
        }];
        [keyItems addObject:keyItem];
        [keyItem release];
    }
    
    keyItem = [[TKKeyItem alloc] initWithInsertText:@"0"];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypeDelete action:^(id<TKTextInput> textInput, TKKeyItem *keyItem) {
        [textInput deleteBackward];
    }];
    keyItem.enablesAutomatically = NO;
    keyItem.enableLongPressRepeat = YES;
    keyItem.backgroundColor = [UIColor colorWithWhite:225/255.0 alpha:1];
    keyItem.highlightBackgroundColor = [UIColor colorWithWhite:251/255.0 alpha:1];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    configiration.keyItems = keyItems;
    [[TKKeyboardManager shareInstance] registerKeyboardConfiguration:configiration];
    [configiration release];
}

@end
