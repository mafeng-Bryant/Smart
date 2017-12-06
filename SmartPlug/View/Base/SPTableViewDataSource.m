//
//  SPTableViewDataSource.m
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTableViewDataSource.h"

@implementation SPTableViewDataSource

- (id)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        self.isRequesting = NO;
        [self setTableView:tableView];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return self;
}

#pragma mark setter and getter

- (void)setTableView:(UITableView *)tableView
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    [_dataSource removeAllObjects];
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
}

- (void)requestDatas:(id)params finished:(void(^)(BOOL result))block
{
    //rewrite subclass    
}

- (BOOL)isEmpty
{
    return _dataSource.count>0?NO:YES;
}

- (void)destroy
{
    [_dataSource removeAllObjects];
    [_tableView reloadData];
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    _tableView = nil;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
