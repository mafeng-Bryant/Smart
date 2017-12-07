//
//  SPDataManager.h
//  SmartPlug
//
//  Created by patpat on 2017/12/3.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPSynchTimeModel.h"
#import "SPPowerDataModel.h"


@interface SPDataManager : NSObject

+ (SPDataManager *)sharedSPDataManager;

//获取同步时间的对象
- (SPSynchTimeModel*)getTimeModel;

//更新时间
- (BOOL)updtaTime:(SPSynchTimeModel*)object;

//是否存储过当天的数据
- (BOOL)hasCurrentDayData;

//保存数据
- (BOOL)savePowerDataModel:(SPPowerDataModel*)model;

//获取当天的数据
- (SPPowerDataModel*)getCurrentDayModel;

//更新当天的数据
- (BOOL)updateCurrentDayModel:(SPPowerDataModel*)model;

//判断每一天是否有数据
- (BOOL)hasEveryDayData:(NSString*)dayString;

//获取每一天的数据
- (SPPowerDataModel*)getEveryDayModel:(NSString*)dayString;

//获取记录的所有月份，按照月份分组
- (NSDictionary*)getAllMonthData;

//获取记录的所有年份，按照年份分组
- (NSDictionary*)getAllYearDatas;


@end
