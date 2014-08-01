//
//  TKFlowLayout.m
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKFlowLayout.h"

@implementation TKFlowLayout

- (CGSize)layoutSubviews:(NSArray*)subviews forView:(UIView*)view {
    CGFloat x = _padding, y = _padding;
    CGFloat maxX = 0, rowHeight = 0;
    CGFloat maxWidth = view.frame.size.width - _padding*2;
    for (UIView* subview in subviews) {
        if (x > _padding && x + subview.frame.size.width > maxWidth) {
            x = _padding;
            y += rowHeight + _spacing;
            rowHeight = 0;
        }
        subview.frame = CGRectMake(x, y, subview.frame.size.width, subview.frame.size.height);
        x += subview.frame.size.width + _spacing;
        if (x > maxX) {
            maxX = x;
        }
        if (subview.frame.size.height > rowHeight) {
            rowHeight = subview.frame.size.height;
        }
    }
    return CGSizeMake(maxX+_padding, y+rowHeight+_padding);
}

@end
