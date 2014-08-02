//
//  TKKeyButton.m
//  TKKeyBoard
//
//  Created by LuoBin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKKeyButton.h"
#import <objc/runtime.h>

#define kDefaultBackgroundColor [UIColor colorWithWhite:251/255.0 alpha:1]
#define kDefaultHighlightedBackgroundColor [UIColor colorWithWhite:179/255.0 alpha:1]

@interface TKKeyButton()

@property (nonatomic, readwrite, retain) TKKeyItem *item;

@property (nonatomic, readwrite, retain) NSTimer *timer;
@property (nonatomic, readwrite, assign) NSUInteger repeatCount;

@end

@implementation TKKeyButton

- (void)dealloc {
    [self removeObserver];
    self.longPressRepeatAction = nil;
    [self stopTimer];
    self.timer = nil;
    self.item = nil;
    [super dealloc];
}

+ (TKKeyButton *)buttonWithItem:(TKKeyItem *)item {
    TKKeyButton *button = nil;
    if (item.customView) {
        button = [TKKeyButton buttonWithCustomView:item.customView];
    } else if (item.image) {
        button = [self buttonWithImage:item.image];
    } else {
        button = [self buttonWithTitle:item.title?:@""];
        if (item.titleFont) {
            button.titleLabel.font = item.titleFont;
        }
        if (item.titleColor) {
            [button setTitleColor:item.titleColor forState:UIControlStateNormal];
        }
        if (item.highlightTitleColor) {
            [button setTitleColor:item.highlightTitleColor forState:UIControlStateHighlighted];
        }
    }
    button.enableLongPressRepeat = item.enableLongPressRepeat;
    if (item.backgroundColor) {
        UIImage *backgroundImage = [self imageWithColor:item.backgroundColor];
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    } else {
        UIImage *backgroundImage = [self imageWithColor:kDefaultBackgroundColor];
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    if (item.highlightBackgroundColor) {
        [button setBackgroundImage:[self imageWithColor:item.highlightBackgroundColor] forState:UIControlStateHighlighted];
    } else {
        UIImage *backgroundImage = [self imageWithColor:kDefaultHighlightedBackgroundColor];
        [button setBackgroundImage:backgroundImage forState:UIControlStateHighlighted];
    }
    button.adjustsImageWhenDisabled = NO;
    button.enabled = item.enable;
    button.item = item;
    [button addObserver];
    return button;
}

#pragma mark - Private

- (void)addObserver {
    [self.item addObserver:self forKeyPath:@"titleFont" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.item addObserver:self forKeyPath:@"titleColor" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.item addObserver:self forKeyPath:@"highlightTitleColor" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.item addObserver:self forKeyPath:@"enable" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.item addObserver:self forKeyPath:@"enableLongPressRepeat" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.item addObserver:self forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.item addObserver:self forKeyPath:@"highlightBackgroundColor" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)removeObserver {
    @try {
        [self.item removeObserver:self forKeyPath:@"titleFont" context:nil];
        [self.item removeObserver:self forKeyPath:@"titleColor" context:nil];
        [self.item removeObserver:self forKeyPath:@"highlightTitleColor" context:nil];
        [self.item removeObserver:self forKeyPath:@"enable" context:nil];
        [self.item removeObserver:self forKeyPath:@"enableLongPressRepeat" context:nil];
        [self.item removeObserver:self forKeyPath:@"backgroundColor" context:nil];
        [self.item removeObserver:self forKeyPath:@"highlightBackgroundColor" context:nil];
    }
    @catch (NSException *exception) {
        //ignore error
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.item) {
        if ([keyPath isEqualToString:@"titleFont"]) {
            if (! self.item.customView && !self.item.image) {
                self.titleLabel.font = self.item.titleFont;
            }
        } else if ([keyPath isEqualToString:@"titleColor"]) {
            if (! self.item.customView && !self.item.image) {
                [self setTitleColor:self.item.titleColor forState:UIControlStateNormal];
            }
        } else if ([keyPath isEqualToString:@"highlightTitleColor"]) {
            if (! self.item.customView && !self.item.image) {
                self.titleLabel.font = self.item.titleFont;
                [self setTitleColor:self.item.highlightTitleColor forState:UIControlStateHighlighted];
            }
        } else if ([keyPath isEqualToString:@"enable"]) {
            self.enabled = self.item.enable;
            
        } else if ([keyPath isEqualToString:@"enablesAutomatically"]) {
            
        } else if ([keyPath isEqualToString:@"enableLongPressRepeat"]) {
            if (![[change objectForKey:NSKeyValueChangeNewKey] isEqualToNumber:[change objectForKey:NSKeyValueChangeOldKey]]) {
                self.enableLongPressRepeat = self.item.enableLongPressRepeat;
            }
        } else if ([keyPath isEqualToString:@"backgroundColor"]) {
            [self setBackgroundImage:[self.class imageWithColor:self.item.backgroundColor] forState:UIControlStateNormal];
        } else if ([keyPath isEqualToString:@"highlightBackgroundColor"]) {
            if (self.item.highlightBackgroundColor) {
                [self setBackgroundImage:[self.class imageWithColor:self.item.highlightBackgroundColor] forState:UIControlStateHighlighted];
            }
        }
    }
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = (CGRect){.size = {1, 1}};
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (TKKeyButton *)buttonWithCustomView:(UIView *)customView {
    TKKeyButton *button = [TKKeyButton buttonWithType:UIButtonTypeCustom];
    customView.frame = button.bounds;
    customView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [button addSubview:customView];
    return button;
}

+ (TKKeyButton *)buttonWithTitle:(NSString *)title {
    TKKeyButton *button = [TKKeyButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:24.0]];
    
    [button setTitleColor:[UIColor colorWithWhite:24/255.0 alpha:1] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:24/255.0 alpha:1] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [button.titleLabel setShadowOffset:CGSizeMake(0, -0.5)];
    return button;
}

+ (TKKeyButton *)buttonWithImage:(UIImage *)image {
    TKKeyButton *button = [TKKeyButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

- (void)startTimer {
    [self stopTimer];
    self.repeatCount = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeFire) userInfo:nil repeats:YES];
}

- (void)stopTimer {
    self.repeatCount = 0;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timeFire {
    if (self.enableLongPressRepeat && self.enabled) {
        self.repeatCount ++;
        if (self.longPressRepeatAction) {
            self.longPressRepeatAction(self);
        }
    } else {
        [self stopTimer];
    }
}

- (void)setLongPressRepeatAction:(void (^)(TKKeyButton *))longPressRepeatAction {
    if (_longPressRepeatAction != longPressRepeatAction) {
        if (longPressRepeatAction) {
            [self addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
            [self addTarget:self action:@selector(buttonDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
            [self addTarget:self action:@selector(buttonTouchedUp:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [self stopTimer];
            [self removeTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
            [self removeTarget:self action:@selector(buttonDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
            [self removeTarget:self action:@selector(buttonTouchedUp:) forControlEvents:UIControlEventTouchUpInside];
        }
        [_longPressRepeatAction release];
        _longPressRepeatAction = [longPressRepeatAction copy];
    }
}

- (void)setEnableLongPressRepeat:(BOOL)enableLongPressRepeat {
    _enableLongPressRepeat = enableLongPressRepeat;
    if (!_enableLongPressRepeat) {
        [self stopTimer];
    }
}

- (void)buttonDragOutside:(id)sender {
    [self stopTimer];
}

- (void)buttonTouchDown:(id)sender {
    [self startTimer];
}

- (void)buttonTouchedUp:(id)sender {
    [self stopTimer];
}

@end
