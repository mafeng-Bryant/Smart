//
//  SPPowerController.h
//  SmartPlug
//
//  Created by patpat on 2017/12/4.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPBaseController.h"
#import <HomeKit/HomeKit.h>


@interface SPPowerController : SPBaseController
@property (nonatomic,strong) HMAccessory* accessory;



@end
