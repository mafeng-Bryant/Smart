//
//  SPPowerDataModel.m
//  SmartPlug
//
//  Created by patpat on 2017/12/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPPowerDataModel.h"

@implementation SPPowerDataModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        SPPowerHourModel*  model_0 = [self getHourModel:0];
        SPPowerHourModel*  model_1 = [self getHourModel:1];
        SPPowerHourModel*  model_2 = [self getHourModel:2];
        SPPowerHourModel*  model_3 = [self getHourModel:3];
        SPPowerHourModel*  model_4 = [self getHourModel:4];
        SPPowerHourModel*  model_5 = [self getHourModel:5];
        SPPowerHourModel*  model_6 = [self getHourModel:6];
        SPPowerHourModel*  model_7 = [self getHourModel:7];
        SPPowerHourModel*  model_8 = [self getHourModel:8];
        SPPowerHourModel*  model_9 = [self getHourModel:9];
        SPPowerHourModel*  model_10 = [self getHourModel:10];
        SPPowerHourModel*  model_11 = [self getHourModel:11];
        SPPowerHourModel*  model_12 = [self getHourModel:12];
        SPPowerHourModel*  model_13 = [self getHourModel:13];
        SPPowerHourModel*  model_14 = [self getHourModel:14];
        SPPowerHourModel*  model_15 = [self getHourModel:15];
        SPPowerHourModel*  model_16 = [self getHourModel:16];
        SPPowerHourModel*  model_17 = [self getHourModel:17];
        SPPowerHourModel*  model_18 = [self getHourModel:18];
        SPPowerHourModel*  model_19 = [self getHourModel:19];
        SPPowerHourModel*  model_20 = [self getHourModel:20];
        SPPowerHourModel*  model_21 = [self getHourModel:21];
        SPPowerHourModel*  model_22 = [self getHourModel:22];
        SPPowerHourModel*  model_23 = [self getHourModel:23];
        _datas = @[model_0,model_1,model_2,model_3,model_4,model_5,model_6,
                   model_7,model_8,model_9,model_10,model_11,model_12,model_13,
                   model_14,model_15,model_16,model_17,model_18,model_19,
                   model_20,model_21,model_22,model_23];
   }
    return self;
}

- (SPPowerHourModel*)getHourModel:(NSInteger)hour
{
    SPPowerHourModel* model = [[SPPowerHourModel alloc]init];
    model.hour = hour;
    model.value = @"0.000";
    return model;
}

#pragma mark WHC_SqliteInfo

+ (NSString *)whc_SqliteVersion
{
    return @"1.2";
}

+ (NSString *)whc_OtherSqlitePath {
    return [NSString stringWithFormat:@"%@/Library/per.db",NSHomeDirectory()];
}


@end
