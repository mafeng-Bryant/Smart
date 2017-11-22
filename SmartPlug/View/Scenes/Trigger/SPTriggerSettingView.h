//
//  SPTriggerSettingView.h
//  SmartPlug
//
//  Created by patpat on 2017/11/14.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTriggerSettingView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

+ (SPTriggerSettingView *)instanceHeadView;

@end
