//
//  SPTriggerSettingView.m
//  SmartPlug
//
//  Created by patpat on 2017/11/14.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTriggerSettingView.h"

@implementation SPTriggerSettingView

+ (SPTriggerSettingView *)instanceHeadView;
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SPTriggerSettingView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
}

@end
