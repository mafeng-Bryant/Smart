//
//  SPTriggerDataSource.h
//  SmartPlug
//
//  Created by patpat on 2017/11/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTableViewDataSource.h"
#import "SPTriggerTableViewInfo.h"

@interface SPTriggerDataSource : SPTableViewDataSource

-(id)initWithTableView:(UITableView *)tableView
         tableViewInfo:(SPTriggerTableViewInfo*)tableViewInfo;

- (void)refreshUI;

@end
