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

- (NSDictionary*)getAllMonthData
{
    NSInteger todayYear = [[[NSDate date] formatYY] integerValue];
    NSMutableArray* monthDatas = [NSMutableArray array];
    NSMutableArray* monthsModels = [NSMutableArray array];
    //查询往后推两年的数据
    for (NSInteger i = 0; i < 2; i++) {
        NSInteger year = todayYear - i;
        NSArray* getAllDays = [WHCSqlite query:[SPPowerDataModel class] where:@""];
        for (SPPowerDataModel* model in getAllDays) {
            if ([[model.date formatYY] integerValue] == year) {//查询对应年份的数据
                NSInteger month = [[model.date formatMM] integerValue];
                if (![monthDatas containsObject:@(month)]) { //将该年的月份有数据的查出来
                    [monthDatas addObject:@(month)];
                    [monthsModels addObject:model];
                }
            }
        }
    }
    return  @{@"month":@(monthDatas.count),@"datas":monthsModels};
}

- (NSDictionary*)getAllYearDatas
{
    NSMutableArray* yearDatas = [NSMutableArray array];
    NSMutableArray* yearModels = [NSMutableArray array];
    NSArray* getAllDays = [WHCSqlite query:[SPPowerDataModel class] where:@""];
    NSArray* years = @[@2020,@2019,@2018,@2017,@2016];
    for (NSInteger i = 0; i< years.count; i++) {
        NSInteger year = [[years objectAtIndex:i] integerValue];
        for (SPPowerDataModel* model in getAllDays) {
            if ([[model.date formatYY] integerValue] == year) {
                NSInteger currentYear = [[model.date formatYY] integerValue];
                if (![yearDatas containsObject:@(currentYear)]) {
                    [yearDatas addObject:@(currentYear)];
                    [yearModels addObject:model];
                }
            }
        }
    }
    return @{@"year":@(yearDatas.count),@"datas":yearModels};
}







@end
