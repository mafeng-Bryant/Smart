//
//  SPPowerDataSource.m
//  SmartPlug
//
//  Created by patpat on 2017/12/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPPowerDataSource.h"
#import "Help.h"
#import "UIView+Extensions.h"
#import "SPPowerInfoCell.h"
#import "SPPowerTableViewInfo.h"
#import "NSDate+Extensions.h"
#import "SPDataManager.h"

@interface SPPowerDataSource()
@property(nonatomic,assign) SPPowerDataSourceSegmentType segmentType;
@property(nonatomic,assign) SPXValueModelType type;

@end

@implementation SPPowerDataSource

-(id)initWithTableView:(UITableView *)tableView
{
    self = [super initWithTableView:tableView];
    if (self) {
        tableView.alpha = 0.0f;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,tableView.width, 0.01f)];
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,tableView.width, 0.01f)];
        tableView.backgroundColor = PPC6;
        [SPPowerInfoCell registerNibToTableView:tableView];
        _type = SPXValueModelTypeConsumption;
    }
    return self;
}

- (void)requestDatas:(id)params finished:(void(^)(BOOL result))block
{
    if (self.isRequesting) return block(NO);
    self.isRequesting = YES;
    _segmentType = (SPPowerDataSourceSegmentType)[params integerValue];
    if (_segmentType == SPPowerDataSourceSegmentTypeDay) { //查询每天的数据源
        //首先查询数据库中是否有当天的数据，没有就用默认值，否则替换默认值
        SPPowerTableViewInfo* tableViewInfo = [[SPPowerTableViewInfo alloc]initWithType:SPPowerDataSourceSegmentTypeDay date:nil];
        tableViewInfo.date = [NSDate date];
        [self.dataSource addObject:tableViewInfo];
        if ([SPDataManager sharedSPDataManager].hasCurrentDayData) {
            SPPowerDataModel* model = [[SPDataManager sharedSPDataManager] getCurrentDayModel];
            for (SPXValueModel* valueModel in tableViewInfo.valueDatas) {
                NSInteger index = [tableViewInfo.valueDatas indexOfObject:valueModel];
                SPPowerHourModel* hourModel = model.datas[index];
                if (hourModel.hour == valueModel.hour) {
                    CGFloat value = [hourModel.value floatValue];
                    NSString* lastValue = [NSString stringWithFormat:@"%.3f",value/1000];
                    valueModel.value = lastValue;
                }
            }
        }
   }else if (_segmentType == SPPowerDataSourceSegmentTypeWeak) { //查询每周的数据源
        //获取当天往下推7天的数据
        for (int i = 0; i < 7; i++) {
            SPPowerTableViewInfo* info = [[SPPowerTableViewInfo alloc]initWithType:SPPowerDataSourceSegmentTypeWeak date:nil];
            info.date = [NSDate dateWithTimeIntervalSinceNow:-i*24*3600];
            [self.dataSource addObject:info];
        }
        //替换每一天的数据
        for (SPPowerTableViewInfo* info in self.dataSource) {
            NSString* dayString = [info.date formatYMD];
            if ([[SPDataManager sharedSPDataManager] hasEveryDayData:dayString]) {
            //更新24小时的数据
            SPPowerDataModel* model = [[SPDataManager sharedSPDataManager] getEveryDayModel:dayString];
                for (SPXValueModel* valueModel in info.valueDatas) {
                    NSInteger index = [info.valueDatas indexOfObject:valueModel];
                    SPPowerHourModel* hourModel = model.datas[index];
                    if (hourModel.hour == valueModel.hour) {
                        CGFloat value = [hourModel.value floatValue];
                        NSString* lastValue = [NSString stringWithFormat:@"%.3f",value/1000];
                        valueModel.value = lastValue;
                    }
                }
            }
        }
   }else if (_segmentType == SPPowerDataSourceSegmentTypeMonth){ //查询每月的数据源
       //首先查询数据库中记录多少月的数据,通过月份分组记录
       NSDictionary* info = [[SPDataManager sharedSPDataManager] getAllMonthData];
       NSArray* datas = info[@"datas"];
       for (NSInteger i = 0; i < [info[@"month"] integerValue]; i++) {
           SPPowerDataModel* model = datas[i];//每一天的对象
           SPPowerTableViewInfo* info = [[SPPowerTableViewInfo alloc]initWithType:SPPowerDataSourceSegmentTypeMonth date:model.date];
           info.date  = model.date;
           [self.dataSource addObject:info];
           //计算每一个月每一天对应的数据,根据日期统计数据
           NSInteger num = [[model.date formatDD] integerValue];
           CGFloat totalValue = 0.0f;
           for ( SPPowerHourModel* hourModel in model.datas)
           {
               CGFloat value = [hourModel.value floatValue];
               NSString* lastValue = [NSString stringWithFormat:@"%.3f",value/1000];
               totalValue+=[lastValue floatValue];
            }
           for (SPXValueModel* valueModel in info.valueDatas) {
               if (valueModel.hour == num) {//取对应日期
                 valueModel.value =  [NSString stringWithFormat:@"%.3f",totalValue];
            }
           }
       }
    }else if (_segmentType == SPPowerDataSourceSegmentTypeYear){ //查询每年的数据源
    //首先查询数据库记录了多少个年，即记录了几年的数据,按照年份分组记录
        NSDictionary* info = [[SPDataManager sharedSPDataManager] getAllYearDatas];
        NSArray* datas = info[@"datas"];
        for (NSInteger i = 0; i < [info[@"year"] integerValue]; i++) {
            SPPowerDataModel* model = datas[i];//每一个月的对象
            SPPowerTableViewInfo* info = [[SPPowerTableViewInfo alloc]initWithType:SPPowerDataSourceSegmentTypeYear date:model.date];
            info.date  = model.date;
            [self.dataSource addObject:info];
            //月份
            NSInteger month = [[model.date formatMM] integerValue];
            CGFloat totalValue = 0.0f;
            for ( SPPowerHourModel* hourModel in model.datas)
            {
                CGFloat value = [hourModel.value floatValue];
                NSString* lastValue = [NSString stringWithFormat:@"%.3f",value/1000];
                totalValue+=[lastValue floatValue];
            }
            for (SPXValueModel* valueModel in info.valueDatas) {
                if (valueModel.hour == month) {//取对应日期
                    valueModel.value =  [NSString stringWithFormat:@"%.3f",totalValue];
                }
            }
        }
    }
    [self.tableView animationShow];
    [self.tableView reloadData];
    if (block) {
        block(YES);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return  self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return VMargin40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SPPowerTableViewInfo* info = self.dataSource[section];
    UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, VMargin40)];
    headView.backgroundColor = PPC6;
    UILabel* titleLbl = [[UILabel alloc]initWithFrame:CGRectZero];
    titleLbl.textColor = PPC3;
    [headView addSubview:titleLbl];
    if (_segmentType == SPPowerDataSourceSegmentTypeDay) {
        titleLbl.text = @"今天";
    }else if (_segmentType == SPPowerDataSourceSegmentTypeWeak){
        titleLbl.text = [info.date formatYMD];
    }else if (_segmentType == SPPowerDataSourceSegmentTypeMonth){
        titleLbl.text = [NSString stringWithFormat:@"%@月份",[info.date formatMM]];
    }else if (_segmentType == SPPowerDataSourceSegmentTypeYear){
        titleLbl.text = [NSString stringWithFormat:@"%@年",[info.date formatYY]];
    }
    [titleLbl sizeToFit];
    titleLbl.frame = CGRectMake(VMargin20, (headView.height-titleLbl.height)/2.0, tableView.width, titleLbl.height);
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPPowerTableViewInfo* info = self.dataSource[indexPath.section];
    SPPowerInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:[SPPowerInfoCell reuseIdentifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configureData:info type:_segmentType costType:_type];
    [cell.segmentControl addTarget:self action:@selector(changeSegmemt:) forControlEvents:UIControlEventValueChanged];
    return cell;
}

- (void)changeSegmemt:(UISegmentedControl*)control
{
    if (control.selectedSegmentIndex ==1) {
        _type = SPXValueModelTypeCost;
    }else {
        _type = SPXValueModelTypeConsumption;
    }
    [self.tableView reloadData];
}


@end
