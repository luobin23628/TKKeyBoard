//
//  TKKeyItem.m
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKKeyItem.h"

@interface TKKeyItem()

@property (nonatomic, readwrite, retain) NSString *title;
@property (nonatomic, readwrite, retain) UIImage *image;
@property (nonatomic, readwrite, retain) UIView *customView;
@property (nonatomic, readwrite, copy) void(^action)(id<UITextInput>);

@end

@implementation TKKeyItem

- (id)initWithType:(TKKeyItemType)type action:(void(^)(id<UITextInput>))action {
    self = [super init];
    if (self) {
        if (type == TKKeyItemTypeDelete) {
            self.image = [UIImage imageNamed:@"delete.png"];
        }
        self.action = action;
    }
    return self;
}

- (id)initWithCustomView:(UIView *)customView action:(void(^)(id<UITextInput>))action {
    self = [super init];
    if (self) {
        self.action = action;
        self.customView = customView;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title action:(void(^)(id<UITextInput>))action {
    self = [super init];
    if (self) {
        self.title = title;
        self.action = action;
    }
    return self;
}

- (id)initWithImage:(UIImage *)image action:(void(^)(id<UITextInput>))action {
    self = [super init];
    if (self) {
        self.image = image;
        self.action = action;
    }
    return self;
}

- (void)dealloc {
    self.title = nil;
    self.image = nil;
    self.customView = nil;
    self.action = nil;
    [super dealloc];
}

@end
