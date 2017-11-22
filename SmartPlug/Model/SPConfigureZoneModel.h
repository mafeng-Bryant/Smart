//
//  SPConfigureZoneModel.h
//  SmartPlug
//
//  Created by patpat on 2017/11/9.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HomeKit/HomeKit.h>
#import "SPConfigureTableViewInfo.h"

@interface SPConfigureZoneModel : NSObject
@property (nonatomic,strong) HMZone* zone;
@property (nonatomic,assign) SPConfigureRowType type;
@property (nonatomic,strong) HMServiceGroup* serviceGroup;
@property (nonatomic,strong) HMTimerTrigger* trigger;



@end
