//
//  TKFlowLayout.h
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKLayout.h"

@interface TKFlowLayout : NSObject <TKLayout>

- (instancetype)initWithSizeForIndexBlock:(CGSize(^)(NSUInteger index, TKFlowLayout *layout, CGRect inRect))sizeForIndexBlock;

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGFloat spacing;

@property (nonatomic, readonly, copy) CGSize(^sizeForIndexBlock)(NSUInteger index, TKFlowLayout *layout, CGRect inRect);

@end
