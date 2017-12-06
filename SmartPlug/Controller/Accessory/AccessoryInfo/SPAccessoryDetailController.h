//
//  SPAccessoryDetailController.h
//  SmartPlug
//
//  Created by patpat on 2017/11/7.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseController.h"
#import <HomeKit/HomeKit.h>

@interface SPAccessoryDetailController : SPBaseController
@property (nonatomic,strong) HMAccessory* accessory;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
