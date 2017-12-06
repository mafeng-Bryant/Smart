//
//  PPTabPageView.m
//  PatPat
//
//  Created by Bruce He on 15/5/20.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPTabPageView.h"

@implementation PPTabPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)initViews{
    //rewrite subclass
}

- (void)setDataSourceClass:(NSString *)classString
{
    //rewrite subclass
}

@end
