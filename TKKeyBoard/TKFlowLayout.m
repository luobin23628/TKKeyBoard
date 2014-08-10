//
//  TKFlowLayout.m
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

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
        if (i == 10) {
            NSLog(@"");
        }
        UIView* subview = [keyButtons objectAtIndex:i];
        CGSize size = self.sizeForIndexBlock(i, self, rect);
        size.width = fix(size.width);
        size.height = fix(size.height);
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
