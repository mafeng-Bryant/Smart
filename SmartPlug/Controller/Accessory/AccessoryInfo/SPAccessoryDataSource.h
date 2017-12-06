//
//  SPAccessoryDataSource.h
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPTableViewDataSource.h"
#import "SPAccessoryTableViewInfo.h"
#import <HomeKit/HomeKit.h>

@interface SPAccessoryDataSource : SPTableViewDataSource
- (id)initWithTableView:(UITableView *)tableView
              accessory:(HMAccessory*)accessory
          tableViewInfo:(SPAccessoryTableViewInfo *)tableViewInfo;

@end

