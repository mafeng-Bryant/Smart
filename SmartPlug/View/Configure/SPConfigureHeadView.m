//
//  SPConfigureHeadView.m
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPConfigureHeadView.h"
#import "Help.h"

@implementation SPConfigureHeadView

-(void)awakeFromNib
{
    [super awakeFromNib];
    _addLbl.textColor = RGB(155,165,167,1.0);
}

+ (SPConfigureHeadView *)instanceHeadView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SPConfigureHeadView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

@end
