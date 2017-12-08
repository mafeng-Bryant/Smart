//
//  SPDataManager.m
//  SmartPlug
//
//  Created by patpat on 2017/12/3.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPDataManager.h"
#import "Help.h"
#import "NSDate+Extensions.h"

@implementation SPDataManager

SINGLETON_GCD(SPDataManager);

//获取同步时间的对象
- (SPSynchTimeModel*)getTimeModel
{
    NSArray* datas = [WHCSqlite query:[SPSynchTimeModel class] where:nil];
    if (datas.count>0) {
        return [datas firstObject];
    }
    return nil;
}

- (BOOL)updtaTime:(SPSynchTimeModel*)object
{
    NSArray* datas = [WHCSqlite query:[SPSynchTimeModel class] where:nil];
    if (datas) {
        [WHCSqlite delete:[SPSynchTimeModel class] where:nil];
    }
    return  [WHCSqlite insert:object];
}

- (BOOL)hasCurrentDayData
{
    NSString* today = [[NSDate date] formatYMD];
    NSString* query = [NSString stringWithFormat:@"day= '%@'",today];
    NSArray* datas = [WHCSqlite query:[SPPowerDataModel class] where:query];
    if (isValidArray(datas) && datas.count>0) {
        return YES;
    }
    return NO;
}

- (BOOL)hasEveryDayData:(NSString*)dayString
{
    NSString* query = [NSString stringWithFormat:@"day= '%@'",dayString];
    NSArray* datas = [WHCSqlite query:[SPPowerDataModel class] where:query];
    if (isValidArray(datas) && datas.count>0) {
        return YES;
    }
    return NO;
}

- (BOOL)savePowerDataModel:(SPPowerDataModel*)model
{
    return [WHCSqlite insert:model];
}

- (SPPowerDataModel*)getCurrentDayModel
{
    NSString* today = [[NSDate date] formatYMD];
    NSString* query = [NSString stringWithFormat:@"day = '%@'",today];
    NSArray* datas = [WHCSqlite query:[SPPowerDataModel class] where:query];
    if (isValidArray(datas)) {
        return [datas lastObject];
    }
    return nil;
}

- (SPPowerDataModel*)getEveryDayModel:(NSString*)dayString
{
    NSString* query = [NSString stringWithFormat:@"day = '%@'",dayString];
    NSArray* datas = [WHCSqlite query:[SPPowerDataModel class] where:query];
    if (isValidArray(datas)) {
        return [datas lastObject];
    }
    return nil;
}

- (BOOL)updateCurrentDayModel:(SPPowerDataModel*)model
{
    NSString* today = [[NSDate date] formatYMD];
    NSString* query = [NSString stringWithFormat:@"day = '%@'",today];
    return  [WHCSqlite update:model where:query];
}

- (NSMutableArray*)getAllMonthData
{
    NSInteger todayYear = [[[NSDate date] formatYY] integerValue];
    NSMutableArray* months = [NSMutableArray array];
    NSMutableArray* monthDatas = [NSMutableArray array];
    NSMutableArray* monthsModels = [NSMutableArray array];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    NSMutableArray* totayYearDatas = [NSMutableArray array];
    //统计今年的每一个月份的数据
    NSArray* getAllDays = [WHCSqlite query:[SPPowerDataModel class] where:@""];
    for (SPPowerDataModel* model in getAllDays) {
        NSInteger year = [[model.date formatYY] integerValue];
        if (year == todayYear) {
            NSInteger month_number = [[model.date formatMM] integerValue];
            if (![months containsObject:@(month_number)]) {
                [months addObject:@(month_number)];
            }
            [totayYearDatas addObject:model];
        }
    }
    
    //按月去对应的每一天的数据，通过key=月份来区分
    for (NSNumber* number in months) {
        for (SPPowerDataModel* model in totayYearDatas) {
            [dic setValue:number forKey:@"monthKey"];
            if ([[model.date formatMM] integerValue] == [number integerValue]) {
                [monthsModels addObject:model];
            }
         }
        [dic setObject:monthsModels forKey:@"datas"];
        [monthDatas addObject:dic];
    }
    return monthDatas;
}

- (NSMutableArray*)getAllYearDatas
{
    NSMutableArray* years = [NSMutableArray array];
    NSMutableArray* months = [NSMutableArray array];
    NSMutableArray* yearModels = [NSMutableArray array];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    NSMutableArray* yearDatas = [NSMutableArray array];

    //统计年数
    NSArray* getAllDays = [WHCSqlite query:[SPPowerDataModel class] where:@""];
    for (SPPowerDataModel* model in getAllDays) {
         NSInteger year = [[model.date formatYY] integerValue];
            if (![years containsObject:@(year)]) {
                [years addObject:@(year)];
            }
    }
    
    for (NSNumber* year in years) {
        [dic setValue:year forKey:@"key"];
        for (SPPowerDataModel* model in getAllDays) {
            if ([[model.date formatYY] integerValue] == [year integerValue]) {
                [yearModels addObject:model];
                NSInteger month = [[model.date formatMM] integerValue];
                if (![months containsObject:@(month)]) {
                    [months addObject:@(month)];
                }
            }
        }
        NSMutableDictionary* monthDic = [NSMutableDictionary dictionary];
        NSMutableArray* month_models = [NSMutableArray array];
        NSMutableArray* month_datas = [NSMutableArray array];
        //在按照月份分组
        for (NSNumber* number in months) {
            for (SPPowerDataModel* model in yearModels) {
                [monthDic setValue:number forKey:@"key"];
                if ([[model.date formatMM] integerValue] == [number integerValue]) {
                    [month_models addObject:model];
                }
            }
            [monthDic setObject:month_models forKey:@"datas"];
            [month_datas addObject:monthDic];
        }
        [dic setObject:month_datas forKey:@"datas"];
        [yearDatas addObject:dic];
    }
    return yearDatas;
}

@end
