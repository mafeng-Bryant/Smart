//
//  PPScrollSegmentControl.m
//  PatPat
//
//  Created by Bruce He on 15/9/22.
//  Copyright © 2015年 http://www.patpat.com. All rights reserved.
//

#import "SPScrollSegmentControl.h"
#import <Masonry/Masonry.h>

#define kButtonTagOffSet 1000
#define kButtonWidth  [UIScreen mainScreen].bounds.size.width/4.0

@interface SPScrollSegmentControl()
{
    UIView *_markLine;
    UIView *bottomSeparateLine;
    NSInteger selectedIndex;
}
@end

@implementation SPScrollSegmentControl

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initConfigure];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfigure];
    }
    return self;
}

- (instancetype)initWithDefaultSelectedIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        [self setDefaultSelectedIndex:index];
    }
    return self;
}

- (void)initConfigure
{
     selectedIndex = 0;
    _buttonItems = [NSMutableArray array];
    _markLine = [[UIView alloc]initWithFrame:CGRectZero];
    _markLine.backgroundColor = PPC1;
    self.backgroundColor = PPC7;
    [self addSubview:_markLine];
    
    bottomSeparateLine = [[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-1, self.frame.size.width,1)];
    bottomSeparateLine.backgroundColor = PPC6;
    [self addSubview:bottomSeparateLine];
}

- (UILabel *)createMiddleSpaceLine
{
    UILabel *_middleLbl = [[UILabel alloc]initWithFrame:CGRectZero];
    _middleLbl.contentMode = UIViewContentModeRedraw;
    _middleLbl.clipsToBounds = YES;
    _middleLbl.backgroundColor = PPC6;
    return _middleLbl;
}

- (void)reloadItems:(NSArray *)items
{
    if (!isValidArray(items) || items.count<1) {
        return;
    }
    [_buttonItems removeAllObjects];
    for (NSInteger index = 0; index < items.count; index++) {
        NSString *title = items[index];
        if (!isValidString(title))continue;
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:PPC3 forState:UIControlStateNormal];
        [button setTitle:title forState:(UIControlStateNormal)];
        button.tag = index+kButtonTagOffSet;
        button.backgroundColor = [UIColor clearColor];
        [self addSubview:button];
        [_buttonItems addObject:button];
        if (index<items.count-1) {
            UILabel *middleLine = [self createMiddleSpaceLine];
            middleLine.hidden = YES;
            [self addSubview:middleLine];
           [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
              make.width.mas_equalTo(VMargin1);
              make.height.mas_equalTo(VMargin15);
              make.centerX.equalTo(self.mas_centerX);
              make.centerY.equalTo(self.mas_centerY);
          }];
       }
    }

    if (_buttonItems.count>0) {
        if (_buttonItems.count==4) {
        
            UIButton* firstBtn = _buttonItems[0];
            UIButton* secondBtn = _buttonItems[1];
            UIButton* thirdBtn = _buttonItems[2];
            UIButton* fourBtn = _buttonItems[3];
   
            [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.equalTo(self).with.offset(0);
                make.width.mas_equalTo(kButtonWidth);
                make.height.mas_equalTo(self.mas_height);
            }];
            [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self).with.offset(0);
                make.leading.equalTo(firstBtn.mas_trailing).with.offset(0);
                make.width.mas_equalTo(kButtonWidth);
                make.height.mas_equalTo(self.mas_height);
            }];
            [thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self).with.offset(0);
                make.leading.equalTo(secondBtn.mas_trailing).with.offset(0);
                make.width.mas_equalTo(kButtonWidth);
                make.height.mas_equalTo(self.mas_height);
            }];
            [fourBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.bottom.equalTo(self).with.offset(0);
                make.width.mas_equalTo(kButtonWidth);
                make.leading.equalTo(thirdBtn.mas_trailing).with.offset(0);
                make.height.mas_equalTo(self.mas_height);
            }];
            
        }else {
        
            for (NSInteger i = 0; i< _buttonItems.count; i++) {
                UIButton *currentButton = _buttonItems[i];
                if (i == _buttonItems.count-1) {
                    break;
                }
                UIButton *nextButton =  _buttonItems[i+1];
                [currentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.equalTo(self).with.offset(0);
                    make.width.equalTo(self.mas_width).with.multipliedBy(.5f);
                    make.height.mas_equalTo(self.mas_height);
                }];
                [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.top.bottom.equalTo(self).with.offset(0);
                    make.leading.equalTo(currentButton.mas_trailing).with.offset(0);
                    make.width.equalTo(currentButton.mas_width);
                }];
            }
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self setSelectedItem:selectedIndex animation:NO];
    });
}

- (void)itemClick:(UIButton *)btn
{
    if (self.controlDelegate && [self.controlDelegate respondsToSelector:@selector(scrollSegment:title:index:)]) {
        NSInteger index = btn.tag - kButtonTagOffSet;
        if (index==selectedIndex)return;
        selectedIndex = btn.tag - kButtonTagOffSet;
        [self.controlDelegate scrollSegment:self title:btn.titleLabel.text index:selectedIndex];
        [self setSelectedItem:selectedIndex];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.frame;
    rect.size.width = [UIScreen mainScreen].bounds.size.width;
    self.frame = rect;
    bottomSeparateLine.frame = CGRectMake(0,self.frame.size.height-bottomSeparateLine.frame.size.height, self.contentSize.width, bottomSeparateLine.frame.size.height);
}

#pragma mark Public

- (void)setDefaultSelectedIndex:(NSInteger)index
{
    selectedIndex = index;
}

- (void)setSelectedItem:(NSInteger)index
{
    [self setSelectedItem:index animation:YES];
}

- (void)setSelectedItem:(NSInteger)index
              animation:(BOOL)animation
{
    selectedIndex = index;
    UIButton *button = (UIButton *)[self viewWithTag:kButtonTagOffSet+index];
    if (button && [button isKindOfClass:[UIButton class]]) {
        for (UIButton *btn in _buttonItems) {
            if (![btn isEqual:button]) {
                [btn setTitleColor:PPC3 forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:PPC1 forState:UIControlStateNormal];
                CGRect lineFrame = CGRectMake(button.frame.origin.x, self.frame.size.height-VMargin4,kButtonWidth,VMargin4);
               if (animation) {
                    [UIView animateWithDuration:0.22 animations:^{
                        _markLine.frame = lineFrame;
                    }];
                }else{
                    _markLine.frame = lineFrame;
                }
            }
        }
    }
}

@end
