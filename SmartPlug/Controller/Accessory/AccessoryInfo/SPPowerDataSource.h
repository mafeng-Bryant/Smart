//
//  SPPowerDataSource.h
//  SmartPlug
//
//  Created by patpat on 2017/12/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTableViewDataSource.h"

typedef enum {
    SPPowerDataSourceSegmentTypeDay=0,//day power
    SPPowerDataSourceSegmentTypeWeak =1,//weak power
    SPPowerDataSourceSegmentTypeMonth =2,//month power
    SPPowerDataSourceSegmentTypeYear = 3//year power
}SPPowerDataSourceSegmentType;

@interface SPPowerDataSource : SPTableViewDataSource

@end
