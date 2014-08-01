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
        _columnCount = 1;
    }
    return self;
}

- (CGSize)layoutSubviews:(NSArray*)subviews forView:(UIView*)view {
    CGFloat innerWidth = (view.frame.size.width - self.padding*2);
    CGFloat innerHeight = (view.frame.size.width - self.padding*2);
    CGFloat width = ceil(innerWidth / self.columnCount);
    CGFloat height = ceil(innerHeight / self.rowCount);

    CGFloat rowHeight = 0;
    
    CGFloat x = _padding, y = _padding;
    CGFloat maxX = 0, lastHeight = 0;
    NSInteger column = 0;
    for (UIView* subview in subviews) {
        if (column % _columnCount == 0) {
            x = _padding;
            y += rowHeight + _spacing;
        }
        CGSize size = [subview sizeThatFits:CGSizeMake(width, 0)];
        rowHeight = size.height;
        subview.frame = CGRectMake(x, y, width, size.height);
        x += subview.frame.size.width + _spacing;
        if (x > maxX) {
            maxX = x;
        }
        lastHeight = subview.frame.size.height;
        ++column;
    }
    
    return CGSizeMake(maxX+_padding, y+lastHeight+_padding);
}

@end
