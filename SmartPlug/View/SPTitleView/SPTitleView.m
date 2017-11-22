//
//  SPTitleView.m
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTitleView.h"
#import "Help.h"

@interface SPTitleView()
{
    NSString* _title;
}

@end

@implementation SPTitleView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        _title = title;
        [self setUp];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _title = @"家";
        [self setUp];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _title = @"家";
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    [self setImage:[UIImage imageNamed:@"btnbg"] forState:UIControlStateNormal];
    [self setBackgroundImage:[[UIImage alloc]init] forState:UIControlStateNormal];
    [self setTitle:_title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}


@end
