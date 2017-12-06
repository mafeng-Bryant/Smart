//
//  SPPowerListPageView.h
//  SmartPlug
//
//  Created by patpat on 2017/12/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "PPTabPageView.h"
#import "SPPowerDataSource.h"

@interface SPPowerListPageView : PPTabPageView
@property(nonatomic,strong,readonly) UITableView* tableView;
@property(nonatomic,strong) SPPowerDataSource* dataSource;

- (void)requestData;

@end
