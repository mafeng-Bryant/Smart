//
//  SPConfigureDataSource.h
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTableViewDataSource.h"
#import "SPTableViewDataSource.h"
#import "SPConfigureTableViewInfo.h"

@interface SPConfigureDataSource : SPTableViewDataSource

-(id)initWithTableView:(UITableView *)tableView
           currentHome:(HMHome*)currentHome
         tableViewInfo:(SPConfigureTableViewInfo*)tableViewInfo;

- (void)setCurrentChooseHome:(HMHome*)home;

@end
