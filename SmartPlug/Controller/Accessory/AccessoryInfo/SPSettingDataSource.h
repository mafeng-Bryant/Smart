//
//  SPSettingDataSource.h
//  SmartPlug
//
//  Created by patpat on 2017/12/1.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTableViewDataSource.h"
#import <HomeKit/HomeKit.h>
#import "SPSettingTableViewInfo.h"

@interface SPSettingDataSource : SPTableViewDataSource

- (id)initWithTableView:(UITableView *)tableView
              accessory:(HMAccessory*)accessory
          tableViewInfo:(SPSettingTableViewInfo *)tableViewInfo;

@end
