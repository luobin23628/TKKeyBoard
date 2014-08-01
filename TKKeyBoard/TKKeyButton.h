//
//  TKKeyButton.h
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKKeyItem.h"

@interface TKKeyButton : UIButton

+ (TKKeyButton *)buttonWithItem:(TKKeyItem *)item;

@property (nonatomic, readonly) TKKeyItem *item;

@end
