//
//  TKFlowLayout.m
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKFlowLayout.h"

@interface TKFlowLayout ()

@property (nonatomic, readwrite, copy) CGSize(^sizeForIndexBlock)(NSUInteger index, TKFlowLayout *layout, CGRect inRect);

@end

@implementation TKFlowLayout

- (instancetype)initWithSizeForIndexBlock:(CGSize(^)(NSUInteger index, TKFlowLayout *layout, CGRect inRect))sizeForIndexBlock {
    self = [super init];
    if (self) {
        NSAssert(sizeForIndexBlock, @"sizeForIndexBlock must not be nil.");
        self.sizeForIndexBlock = sizeForIndexBlock;
        self.spacing = 0.5;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self doesNotRecognizeSelector:_cmd];
    }
    return self;
}

- (void)dealloc {
    self.sizeForIndexBlock = nil;
    [super dealloc];
}

- (void)layoutKeyButtons:(NSArray*)keyButtons inRect:(CGRect)rect {
    CGFloat x = self.padding, y = self.padding;
    CGFloat maxX = 0, rowHeight = 0;
    CGFloat maxWidth = rect.size.width - self.padding*2;
    for (int i = 0; i < [keyButtons count]; i++) {
        UIView* subview = [keyButtons objectAtIndex:i];
        CGSize size = self.sizeForIndexBlock(i, self, rect);
        if (x > self.padding && x + size.width > maxWidth) {
            x = self.padding;
            y += rowHeight + self.spacing;
            rowHeight = 0;
        }
        subview.frame = CGRectMake(x, y, size.width, size.height);
        x += size.width + self.spacing;
        if (x > maxX) {
            maxX = x;
        }
        if (size.height > rowHeight) {
            rowHeight = size.height;
        }
    }
}

@end
