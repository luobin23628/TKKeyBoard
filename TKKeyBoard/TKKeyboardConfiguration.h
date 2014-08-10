//
//  TKKeyboardConfiguration.h
//  TKKeyBoard
//
//  Created by luobin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKKeyItem.h"
#import "TKLayout.h"

@interface TKKeyboardConfiguration : NSObject

@property (nonatomic, assign) NSInteger keyboardType;
@property (nonatomic, retain) NSArray *keyItems;
@property (nonatomic, retain) id<TKLayout> layout;    //Default TKGridLayout

@property (nonatomic, retain) UIColor *backgroundColor;  //Default [UIColor colorWithWhite:251/255.0 alpha:1]
@property (nonatomic, retain) UIView *backgroundView;  //Default nil

@property (nonatomic, assign) CGFloat keyboardHeight;  //Default 216.f
@property (nonatomic, assign) CGFloat landscapeKeyboardHeight;  //Default 140.f

@end
