//
//  SPPowerHourModel.m
//  SmartPlug
//
//  Created by patpat on 2017/12/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPPowerHourModel.h"
#import "WHC_ModelSqlite.h"

@implementation SPPowerHourModel

/// 使用WHC_Model库自动实现NSCoding协议
WHC_CodingImplementation

+ (NSString *)whc_SqliteVersion
{
    return @"1.2";
}

@end
