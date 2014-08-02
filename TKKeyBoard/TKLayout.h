//
//  TKLayout.h
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TKLayout <NSObject>

- (void)layoutKeyButtons:(NSArray*)keyButtons forContainer:(UIView*)container;

@end
