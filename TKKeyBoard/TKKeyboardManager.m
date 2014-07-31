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

@end
