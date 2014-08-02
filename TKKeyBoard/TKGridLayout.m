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
    }
    return self;
}

- (void)shiftTop:(NSUInteger)gridIndex {
    
}

- (void)shiftLeft:(NSUInteger)gridIndex {
    
}

- (void)shiftBottom:(NSUInteger)gridIndex {
    
}

- (void)shiftRight:(NSUInteger)gridIndex {
    
}

- (void)shiftEntireRow:(NSUInteger)gridIndex {
    
}

- (void)shiftEntireColumn:(NSUInteger)gridIndex {
    
}

- (CGSize)layoutSubviews:(NSArray*)subviews forView:(UIView*)view {
    NSAssert(self.padding >= 0, @"self.padding >= 0");
    NSAssert(self.spacing >= 0, @"self.padding >= 0");
    CGFloat innerWidth = (view.frame.size.width - self.padding*2  - (self.columnCount - 1) *self.spacing);
    CGFloat innerHeight = (view.frame.size.height - self.padding*2 - (self.rowCount - 1) *self.spacing);
    CGFloat width = ceil(innerWidth / self.columnCount);
    CGFloat height = ceil(innerHeight / self.rowCount);
    
    CGFloat maxX = 0, maxY = 0, x = 0, y = 0;
    
    for (NSUInteger i = 0; i < self.rowCount; i++) {
        for (NSUInteger j = 0; j < self.columnCount; j++) {
            NSUInteger index = i * self.columnCount + j;
            if (index >= [subviews count]) {
                break;
            }
            UIView *subview = [subviews objectAtIndex:index];
            subview.layer.borderWidth = 0.5;
            subview.layer.borderColor = [UIColor colorWithWhite:179/255.0 alpha:1].CGColor;
            
            x = self.padding + j * (width + self.spacing);
            y = self.padding + i * (height + self.spacing);
            subview.frame = CGRectMake(x, y, width, height);
            maxX = MAX(maxX, x);
            maxY = MAX(maxY, y);
        }
    }
    return CGSizeMake(maxX + self.padding, maxY + self.padding);
}

@end
