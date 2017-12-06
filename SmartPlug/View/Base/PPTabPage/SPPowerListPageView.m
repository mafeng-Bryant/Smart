//
//  SPPowerListPageView.m
//  SmartPlug
//
//  Created by patpat on 2017/12/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPPowerListPageView.h"
#import "PPLoadingView.h"

@implementation SPPowerListPageView

- (void)initViews
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,_tableView.frame.size.width, 0.01f)];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,_tableView.frame.size.width, 0.01f)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:_tableView];
    }
}

- (void)setDataSourceClass:(NSString *)classString
{
    if (!_dataSource) {
        [self initViews];
        _dataSource = [[NSClassFromString(classString) alloc]initWithTableView:_tableView];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _tableView.frame = self.bounds;
}

- (void)requestData
{
    if (!self.dataSource.isRequesting && self.dataSource.isEmpty) {
        PPLoadingView* loadingView = [PPLoadingView showTo:self];
        [self.dataSource requestDatas:@(self.pageIndex) finished:^(BOOL result) {
            [loadingView hide];
        }];
    }
}

@end
