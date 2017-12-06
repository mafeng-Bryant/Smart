//
//  SPDataManager.m
//  SmartPlug
//
//  Created by patpat on 2017/12/3.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPDataManager.h"
#import "Help.h"

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

@end
