//
//  TKKeyItem.h
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TKKeyItemType) {
    TKKeyItemTypeDelete,
    TKKeyItemTypeBackspace,
};

@interface TKKeyItem : NSObject

- (id)initWithType:(TKKeyItemType)type action:(void(^)(id<UITextInput>))action;
- (id)initWithTitle:(NSString *)title action:(void(^)(id<UITextInput>))action;
- (id)initWithImage:(UIImage *)image action:(void(^)(id<UITextInput>))action;
- (id)initWithCustomView:(UIView *)customView action:(void(^)(id<UITextInput>))action;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) UIView *customView;
@property (nonatomic, readonly) void(^action)(id<UITextInput>);

@end
