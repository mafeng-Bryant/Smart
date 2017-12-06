//
//  SPSettingController.h
//  SmartPlug
//
//  Created by patpat on 2017/11/30.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPBaseController.h"
#import <HomeKit/HomeKit.h>

@interface SPSettingController : SPBaseController
@property (nonatomic,strong) HMAccessory* accessory;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
