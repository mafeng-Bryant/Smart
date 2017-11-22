//
//  SPHelpHeaderView.m
//  SmartPlug
//
//  Created by patpat on 2017/11/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPHelpHeaderView.h"
#import "Help.h"

@implementation SPHelpHeaderView

+ (SPHelpHeaderView *)instanceHeadView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SPHelpHeaderView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

-(void)awakeFromNib
{
    self.backgroundColor = RGB(241,243,242,1.0);
    _titleLbl.textColor = RGB(155,165,167,1.0);
    _titleLbl.font = [UIFont systemFontOfSize:11];
    [super awakeFromNib];
}

@end
