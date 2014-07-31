//
//  TKKeyboardManager.h
//  TKKeyBoard
//
//  Created by luobin on 14-7-31.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKKeyboardConfiguration.h"

@interface TKKeyboardManager : NSObject

+ (instancetype)shareInstance;

- (void)registerKeyboardConfiguration:(TKKeyboardConfiguration *)keyboardConfiguration;

- (TKKeyboardConfiguration *)configurationForKeyboardType:(NSInteger)keyboardType;

@end
