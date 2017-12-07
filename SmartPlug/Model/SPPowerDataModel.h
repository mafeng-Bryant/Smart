//
//  SPPowerDataModel.h
//  SmartPlug
//
//  Created by patpat on 2017/12/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPPowerHourModel.h"
#import "WHC_ModelSqlite.h"

@interface SPPowerDataModel : NSObject<WHC_SqliteInfo>
@property (nonatomic,strong) NSString* day;//2017-12-07
@property (nonatomic,strong) NSDate* date;//以每一天纬度作为标准，存到数据库
@property (nonatomic,strong) NSArray* datas;

+ (NSString *)whc_SqliteVersion;


@end
