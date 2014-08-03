//
//  TKKeyItem.m
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKKeyItem.h"
#import "TKKeyboard.h"

@interface TKKeyItem()

@property (nonatomic, readwrite, retain) NSString *title;
@property (nonatomic, readwrite, retain) NSAttributedString *attributedTitle;
@property (nonatomic, readwrite, retain) UIImage *image;
@property (nonatomic, readwrite, retain) UIView *customView;
@property (nonatomic, readwrite, copy) void(^action)(id<TKTextInput> textInput, TKKeyItem *keyItem);

@end

@implementation TKKeyItem

- (id)init {
    self = [super init];
    if (self) {
        self.enable = YES;
        self.enableLongPressRepeat = NO;
        self.enablesAutomatically = NO;
    }
    return self;
}

- (id)initWithType:(TKKeyItemType)type action:(void(^)(id<TKTextInput> textInput, TKKeyItem *keyItem))action {
    self = [self init];
    if (self) {
        if (type == TKKeyItemTypeDelete) {
            self.image = [UIImage imageNamed:@"delete.png"];
            self.enableLongPressRepeat = YES;
        } else if (type == TKKeyItemTypeReturn) {
            self.title = @"完 成";
            self.enablesAutomatically = YES;
        } else if (type == TKKeyItemTypeBackspace) {
            self.image = nil;
            self.title = nil;
        } else if (type == TKKeyItemTypePositiveOrNegative) {
            self.title = @"-/+";
        }
        self.action = action;
    }
    return self;
}

- (id)initWithCustomView:(UIView *)customView action:(void(^)(id<TKTextInput> textInput, TKKeyItem *keyItem))action {
    self = [self init];
    if (self) {
        self.action = action;
        self.customView = customView;
    }
    return self;
}

- (id)initWithInsertText:(NSString *)insertText {
    return [self initWithTitle:insertText action:^(id<TKTextInput> textInput, TKKeyItem *keyItem) {
        [textInput insertText:insertText];
    }];
}

- (id)initWithTitle:(NSString *)title action:(void(^)(id<TKTextInput> textInput, TKKeyItem *keyItem))action {
    self = [self init];
    if (self) {
        self.title = title;
        self.action = action;
    }
    return self;
}

- (id)initWithAttributedString:(NSAttributedString *)attributedTitle action:(void(^)(id<TKTextInput> textInput, TKKeyItem *keyItem))action {
    self = [self init];
    if (self) {
        self.attributedTitle = attributedTitle;
        self.action = action;
    }
    return self;
}

- (id)initWithImage:(UIImage *)image action:(void(^)(id<TKTextInput> textInput, TKKeyItem *keyItem))action {
    self = [self init];
    if (self) {
        self.image = image;
        self.action = action;
    }
    return self;
}

- (void)dealloc {
    self.title = nil;
    self.attributedTitle = nil;
    self.image = nil;
    self.customView = nil;
    self.action = nil;
    self.titleFont = nil;
    self.titleColor = nil;
    self.highlightTitleColor = nil;
    self.backgroundColor = nil;
    self.highlightBackgroundColor = nil;
    [super dealloc];
}

@end
