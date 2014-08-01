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

@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, assign) CGSize keyboardSize;
@property (nonatomic, assign) NSInteger keyboardType;
@property (nonatomic, retain) NSArray *keyItems;
@property (nonatomic, retain) TKLayout *layout;

@end
