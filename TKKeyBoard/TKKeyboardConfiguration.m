//
//  TKKeyboardConfiguration.m
//  TKKeyBoard
//
//  Created by luobin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKKeyboardConfiguration.h"

@implementation TKKeyboardConfiguration

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    self.backgroundView = nil;
    self.backgroundColor = nil;
    self.layout = nil;
    self.keyItems = nil;
    [super dealloc];
}

@end
