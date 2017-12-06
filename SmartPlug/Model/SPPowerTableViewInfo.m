//
//  SPPowerTableViewInfo.m
//  SmartPlug
//
//  Created by patpat on 2017/12/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPPowerTableViewInfo.h"

@implementation SPPowerTableViewInfo

-(instancetype)init
{
    self = [super init];
    if (self) {
        _yyModel = [[SPYYModel alloc]init];
        _valueDatas = [NSMutableArray array];
         NSArray* datas = @[@"0.000",@"0.000",@"0.500",@"0.050",@"1.000",@"0.000",@"0.000",@"0.000",@"0.000",@"0.000",@"0.000",@"0.000",@"0.000",@"0.000",@"0.000",@"0.000",@"0.000",@"0.000",@"0.000",@"0.000",@"0.004",@"0.016",@"0.009",@"0.000"];
        //从数据库去数据的时候，根据对应的时间点替换value
        for (NSInteger i = 0; i< datas.count; i++) {
            SPXValueModel* model = [[SPXValueModel alloc]init];
            model.hour = i;
            model.value = datas[i];
            [_valueDatas addObject:model];
        }
    }
    return self;
}

@end
