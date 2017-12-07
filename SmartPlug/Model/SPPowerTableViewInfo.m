//
//  SPPowerTableViewInfo.m
//  SmartPlug
//
//  Created by patpat on 2017/12/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPPowerTableViewInfo.h"
#import "NSDate+Extensions.h"

@interface SPPowerTableViewInfo()
{
    SPPowerDataSourceSegmentType _type;
    NSDate* _date;
}

@end
@implementation SPPowerTableViewInfo

-(instancetype)initWithType:(SPPowerDataSourceSegmentType)type date:(NSDate*)date
{
    self = [super init];
    if (self) {
        _type = type;
        _date = date;
        [self configureData];
    }
    return self;
}

- (void)configureData
{
    _yyModel = [[SPYYModel alloc]init];
    _valueDatas = [NSMutableArray array];
    if ((_type == SPPowerDataSourceSegmentTypeDay) || (_type == SPPowerDataSourceSegmentTypeWeak)) {
        //从数据库去数据的时候，根据对应的时间点替换value
        for (NSInteger i = 0; i< 24; i++) {
            SPXValueModel* model = [[SPXValueModel alloc]init];
            model.hour = i;
            model.value = @"0.000";
            [_valueDatas addObject:model];
        }
     }else if (_type == SPPowerDataSourceSegmentTypeMonth){
        //判断每一个月有多少天
         NSInteger month = [[_date formatMM] integerValue];
         NSInteger year = [[_date formatYY] integerValue];
         NSInteger days = [NSDate monthDays:month year:year];
         for (NSInteger i = 0; i < days; i++) {
             SPXValueModel* model = [[SPXValueModel alloc]init];
             model.hour = i+1;
             model.value = @"0.000";
             [_valueDatas addObject:model];
        }
    }else if (_type == SPPowerDataSourceSegmentTypeYear){
        //每年12个月
        for (NSInteger i = 0; i< 12; i++) {
            SPXValueModel* model = [[SPXValueModel alloc]init];
            model.hour = i+1;
            model.value = @"0.000";
            [_valueDatas addObject:model];
        }
    }
}


@end
