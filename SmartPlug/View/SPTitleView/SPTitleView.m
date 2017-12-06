//
//  SPTitleView.m
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTitleView.h"
#import "Help.h"

#define kDefaultWidth 135
#define kDefaultHeight 36

@interface SPTitleView()
{
    NSString* _title;
    UILabel* _tipsLbl;
    UIImageView* _imageView;
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
    _imageView = [[UIImageView alloc]init];
    _imageView.image = Image(@"btnbg");
    _imageView.frame = self.bounds;
    [self addSubview:_imageView];
    _tipsLbl = [[UILabel alloc]init];
    _tipsLbl.text = _title;
    _tipsLbl.font = [UIFont fontWithName:@"Avenir-Roman" size:16];
    [_tipsLbl sizeToFit];
    _tipsLbl.textColor = [UIColor whiteColor];
    [self addSubview:_tipsLbl];
   
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.frame;
    rect.size.width = kDefaultWidth;
    rect.size.height = kDefaultHeight;
    if (_tipsLbl.frame.size.width > kDefaultWidth) {
        rect.size.width = _tipsLbl.frame.size.width + VMargin20;
    }
    self.frame = rect;
    _imageView.frame = self.bounds;
     _tipsLbl.frame = CGRectMake((self.frame.size.width-_tipsLbl.frame.size.width)/2.0, (self.frame.size.height-_tipsLbl.frame.size.height)/2.0, _tipsLbl.frame.size.width, _tipsLbl.frame.size.height);
    
}


@end
