//
//  SPConfigureTableViewInfo.m
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPConfigureTableViewInfo.h"
#import "Help.h"
#import "SPConfigureZoneModel.h"

@implementation SPConfigureTableViewRowObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 0.0f;
        self.title = @"";
        self.value = @"";
        self.type = SPConfigureRowTypeZones;
    }
    return self;
}

@end

@implementation SPConfigureTableViewSectionObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerHeight = 10.0f;
    }
    return self;
}
@end

@implementation SPConfigureTableViewInfo

- (void)configureData:(NSMutableArray *)data
                 home:(HMHome*)currentHome
   containerViewWidth:(float)width
{
    [data removeAllObjects];
    
    /*=== User ===*/ //
    SPConfigureTableViewSectionObject *sectionObject = [[SPConfigureTableViewSectionObject alloc]init];
    sectionObject.type = SPConfigureSectionTypeUser;
    sectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:sectionObject];
    
    //默认行
    SPConfigureTableViewRowObject *rowObject = [[SPConfigureTableViewRowObject alloc]init];
    rowObject.height = VMargin1;
    rowObject.type = SPConfigureRowTypeDefault;
    [sectionObject.rows addObject:rowObject];
    
    
    /*=== Zones ===*/ //
    SPConfigureTableViewSectionObject *zoneSectionObject = [[SPConfigureTableViewSectionObject alloc]init];
    zoneSectionObject.type = SPConfigureSectionTypeZones;
    zoneSectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:zoneSectionObject];
    
    rowObject = [[SPConfigureTableViewRowObject alloc]init];
    rowObject.height = VMargin1;
    rowObject.type = SPConfigureRowTypeDefault;
    [zoneSectionObject.rows addObject:rowObject];
    
    for (HMZone* zone in currentHome.zones) {
        rowObject = [[SPConfigureTableViewRowObject alloc]init];
        rowObject.height = VMargin60;
        rowObject.type = SPConfigureRowTypeZones;
        SPConfigureZoneModel* model = [[SPConfigureZoneModel alloc]init];
        model.zone = zone;
        model.type = SPConfigureRowTypeZones;
        rowObject.model = model;
        [zoneSectionObject.rows addObject:rowObject];
    }
    
    /*=== Services ===*/ //
    SPConfigureTableViewSectionObject *serviceSectionObject = [[SPConfigureTableViewSectionObject alloc]init];
    serviceSectionObject.type = SPConfigureSectionTypeServiceGroup;
    serviceSectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:serviceSectionObject];
    
    rowObject = [[SPConfigureTableViewRowObject alloc]init];
    rowObject.height = VMargin1;
    rowObject.type = SPConfigureRowTypeDefault;
    [serviceSectionObject.rows addObject:rowObject];
    
    for (HMServiceGroup* serviceGroup in currentHome.serviceGroups) {
        rowObject = [[SPConfigureTableViewRowObject alloc]init];
        rowObject.height = VMargin60;
        rowObject.type = SPConfigureRowTypeService;
        SPConfigureZoneModel* model = [[SPConfigureZoneModel alloc]init];
        model.type = SPConfigureRowTypeService;
        model.serviceGroup = serviceGroup;
        rowObject.model = model;
        [serviceSectionObject.rows addObject:rowObject];
    }

    /*=== Triggers ===*/ //
    SPConfigureTableViewSectionObject *triggerSectionObject = [[SPConfigureTableViewSectionObject alloc]init];
    triggerSectionObject.type = SPConfigureSectionTypeTriggers;
    triggerSectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:triggerSectionObject];
  
    rowObject = [[SPConfigureTableViewRowObject alloc]init];
    rowObject.height = VMargin1;
    rowObject.type = SPConfigureRowTypeDefault;
    [triggerSectionObject.rows addObject:rowObject];
    
    //获取触发器信息
    for (HMTimerTrigger* trigger in currentHome.triggers) {
        rowObject = [[SPConfigureTableViewRowObject alloc]init];
        rowObject.height = VMargin60;
        rowObject.type = SPConfigureRowTypeTriggers;
        SPConfigureZoneModel* model = [[SPConfigureZoneModel alloc]init];
        model.trigger = trigger;
        model.type = SPConfigureRowTypeTriggers;
        rowObject.model = model;
        [triggerSectionObject.rows addObject:rowObject];
    }
}

@end
