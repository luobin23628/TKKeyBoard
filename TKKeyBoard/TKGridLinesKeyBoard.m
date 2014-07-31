//
//  TKGridLinesKeyBoard.m
//  TKKeyBoard
//
//  Created by luobin on 14-8-1.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKGridLinesKeyBoard.h"
#import "TKGridLinesTexturedView.h"

@interface TKGridLinesKeyBoard ()

@property (nonatomic,assign) TKGridLinesTexturedView *texturedView;

@end

@implementation TKGridLinesKeyBoard

- (id)initWithConfiguration:(TKKeyboardConfiguration *)configuration {
    self = [super initWithConfiguration:configuration];
    if (self) {
        // Initialization code
        self.texturedView = [[[TKGridLinesTexturedView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] autorelease];
        self.texturedView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.texturedView.backgroundColor = [UIColor colorWithWhite:251/255.0 alpha:1];
        [self addSubview:self.texturedView];
    }
    return self;
}

- (void)dealloc {
    self.texturedView = nil;
    [super dealloc];
}

@end
