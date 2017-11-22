//
//  SPSceneSetActionDataSource.h
//  SmartPlug
//
//  Created by patpat on 2017/11/10.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTableViewDataSource.h"
#import <HomeKit/HomeKit.h>
#import "SPActionSetTableViewInfo.h"
#import "SPActionSetModel.h"

@interface SPSceneSetActionDataSource : SPTableViewDataSource

- (id)initWithTableView:(UITableView *)tableView
                  model:(SPActionSetModel*)model
          tableViewInfo:(SPActionSetTableViewInfo *)tableViewInfo;

- (void)setCurrentChooseHome:(HMHome*)home;



@end
