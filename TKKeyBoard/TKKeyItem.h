//
//  TKKeyItem.h
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TKTextInput;

typedef NS_ENUM(NSInteger, TKKeyItemType) {
    TKKeyItemTypeDelete,
    TKKeyItemTypeReturn,
    TKKeyItemTypeBackspace,
    TKKeyItemTypePositiveOrNegative,
};

@interface TKKeyItem : NSObject

- (id)initWithType:(TKKeyItemType)type action:(void(^)(id<TKTextInput> textInput, TKKeyItem *keyItem))action;
- (id)initWithInsertText:(NSString *)insertText;
- (id)initWithTitle:(NSString *)title action:(void(^)(id<TKTextInput> textInput, TKKeyItem *keyItem))action;
- (id)initWithAttributedString:(NSAttributedString *)attributedTitle action:(void(^)(id<TKTextInput> textInput, TKKeyItem *keyItem))action;
- (id)initWithImage:(UIImage *)image action:(void(^)(id<TKTextInput> textInput, TKKeyItem *keyItem))action;
- (id)initWithCustomView:(UIView *)customView action:(void(^)(id<TKTextInput> textInput, TKKeyItem *keyItem))action;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSAttributedString *attributedTitle;
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) UIView *customView;
@property (nonatomic, readonly) void(^action)(id<TKTextInput> textInput, TKKeyItem *keyItem);

//for title button
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIColor *highlightTitleColor;


//for all button
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) BOOL enablesAutomatically;   //default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)

@property (nonatomic, assign) BOOL enableLongPressRepeat;     //default NO
@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) UIColor *highlightBackgroundColor;

@end
