//
//  SPStatisticalController.h
//  SmartPlug
//
//  Created by patpat on 2017/11/30.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPBaseController.h"
#import <HomeKit/HomeKit.h>
#import "SPGaugeView.h"

@interface SPStatisticalController : SPBaseController
@property (nonatomic,strong) HMAccessory* accessory;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet SPGaugeView *gaugeView;
@property (weak, nonatomic) IBOutlet UIButton *currentLowerLbl;
@property (weak, nonatomic) IBOutlet UIButton *currentTimeLbl;

@end
