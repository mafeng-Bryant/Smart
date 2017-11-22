//
//  SPTriggerNormalView.h
//  SmartPlug
//
//  Created by patpat on 2017/11/14.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTriggerNormalView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

+ (SPTriggerNormalView *)instanceHeadView;

@end
