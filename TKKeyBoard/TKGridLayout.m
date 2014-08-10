//
//  TKGridLayout.m
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKGridLayout.h"

@implementation TKGridLayout

- (id)init {
    if (self = [super init]) {
        self.columnCount = 3;
        self.rowCount = 3;
        self.spacing = 0.5;
    }
    return self;
}

- (void)layoutKeyButtons:(NSArray*)keyButtons inRect:(CGRect)rect {
    NSAssert(self.padding >= 0, @"self.padding >= 0");
    NSAssert(self.spacing >= 0, @"self.padding >= 0");
    CGFloat innerWidth = (rect.size.width - self.padding*2  - (self.columnCount - 1) *self.spacing);
    CGFloat innerHeight = (rect.size.height - self.padding*2 - (self.rowCount - 1) *self.spacing);
    CGFloat width = ceil(innerWidth / self.columnCount);
    CGFloat height = ceil(innerHeight / self.rowCount);
    
    CGFloat x = 0, y = 0;
    
    for (NSUInteger i = 0; i < self.rowCount; i++) {
        for (NSUInteger j = 0; j < self.columnCount; j++) {
            NSUInteger index = i * self.columnCount + j;
            if (index >= [keyButtons count]) {
                break;
            }
            UIView *subview = [keyButtons objectAtIndex:index];
            x = self.padding + j * (width + self.spacing);
            y = self.padding + i * (height + self.spacing);
            subview.frame = CGRectMake(x, y, width, height);
        }
    }
}

@end
