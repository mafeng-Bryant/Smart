//
//  SPTriggerNameView.m
//  SmartPlug
//
//  Created by patpat on 2017/11/14.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTriggerNameView.h"

@implementation SPTriggerNameView

+ (SPTriggerNameView *)instanceHeadView;
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SPTriggerNameView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
}


@end
