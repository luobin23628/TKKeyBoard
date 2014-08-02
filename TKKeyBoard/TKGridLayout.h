//
//  TKGridLayout.h
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKLayout.h"

@interface TKGridLayout : NSObject <TKLayout>

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGFloat spacing;
@property (nonatomic, assign) NSUInteger rowCount;
@property (nonatomic, assign) NSUInteger columnCount;

@end
