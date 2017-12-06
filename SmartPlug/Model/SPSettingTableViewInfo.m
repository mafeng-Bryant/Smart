//
//  SPSettingTableViewInfo.m
//  SmartPlug
//
//  Created by patpat on 2017/12/1.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPSettingTableViewInfo.h"
#import <HomeKit/HomeKit.h>
#import "SPSynchTimeModel.h"
#import "SPDataManager.h"
#import "NSDate+Extensions.h"

@implementation SPSettingTableViewRowObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 0.0f;
        self.title = @"";
        self.value = @"";
        self.type = SPSettingTableViewRowTypeCommon;
    }
    return self;
}

@end

@implementation SPSettingTableViewSectionObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerHeight = 10.0f;
    }
    return self;
}
@end

@implementation SPSettingTableViewInfo

- (void)configureData:(NSMutableArray *)data
            accessory:(HMAccessory*)accessory
   containerViewWidth:(float)width
{
    if (!accessory) {
        return;
    }
    [data removeAllObjects];
    
    /*=== info ===*/ //
    SPSettingTableViewSectionObject *sectionObject = [[SPSettingTableViewSectionObject alloc]init];
    sectionObject.type = SPSettingTableViewSectionTypeInfo;
    sectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:sectionObject];
    
    SPSettingTableViewRowObject *rowObject = [[SPSettingTableViewRowObject alloc]init];
    rowObject.height = 55;
    rowObject.title = @"制造商";
    rowObject.value = accessory.manufacturer;
    rowObject.type = SPSettingTableViewRowTypeCommon;
    [sectionObject.rows addObject:rowObject];
    
    rowObject = [[SPSettingTableViewRowObject alloc]init];
    rowObject.height = 55;
    rowObject.title = @"识别";
    rowObject.value = @"点击识别设备";
    rowObject.type = SPSettingTableViewRowTypeRegnize;
    [sectionObject.rows addObject:rowObject];

    rowObject = [[SPSettingTableViewRowObject alloc]init];
    rowObject.height = 55;
    rowObject.title = @"名称";
    rowObject.value = accessory.name;
    rowObject.type = SPSettingTableViewRowTypeCommon;
    [sectionObject.rows addObject:rowObject];
   
    rowObject = [[SPSettingTableViewRowObject alloc]init];
    rowObject.height = 55;
    rowObject.title = @"序列号";
    rowObject.value = accessory.uniqueIdentifier.UUIDString;
    rowObject.type = SPSettingTableViewRowTypeCommon;
    [sectionObject.rows addObject:rowObject];

    rowObject = [[SPSettingTableViewRowObject alloc]init];
    rowObject.height = 55;
    rowObject.title = @"固件版本";
    rowObject.value = accessory.firmwareVersion;
    rowObject.type = SPSettingTableViewRowTypeCommon;
    [sectionObject.rows addObject:rowObject];
    
    rowObject = [[SPSettingTableViewRowObject alloc]init];
    rowObject.height = 55;
    rowObject.title = @"型号";
    rowObject.value = accessory.model;
    rowObject.type = SPSettingTableViewRowTypeCommon;
    [sectionObject.rows addObject:rowObject];
    
    /*=== update version ===*/ //
    SPSettingTableViewSectionObject *versionSectionObject = [[SPSettingTableViewSectionObject alloc]init];
    versionSectionObject.type = SPSettingTableViewSectionTypeVersion;
    versionSectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:versionSectionObject];
    
    rowObject = [[SPSettingTableViewRowObject alloc]init];
    rowObject.height = 55;
    rowObject.title = @"通过data升级";
    rowObject.value = @"点击升级固件";
    rowObject.type = SPSettingTableViewRowTypeUpdataVersion;
    [versionSectionObject.rows addObject:rowObject];
    
    /*=== update time ===*/ //
    SPSettingTableViewSectionObject *timeSectionObject = [[SPSettingTableViewSectionObject alloc]init];
    timeSectionObject.type = SPSettingTableViewSectionTypeSynchTime;
    timeSectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:timeSectionObject];
    
    rowObject = [[SPSettingTableViewRowObject alloc]init];
    rowObject.height = 55;
    rowObject.title = [self getTime];
    rowObject.value = @"点击同步时间";
    rowObject.type = SPSettingTableViewRowTypeUpdateTime;
    [timeSectionObject.rows addObject:rowObject];
}

- (NSString*)getTime
{
    SPSynchTimeModel* model = [[SPDataManager sharedSPDataManager] getTimeModel];
    if (model) {
        return  [NSString stringWithFormat:@"时间: %@ 时区:8",model.dateString];
    }else {
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:0];
        SPSynchTimeModel* model = [[SPSynchTimeModel alloc]init];
        model.dateString = [date formatHMSYMD];
        [[SPDataManager sharedSPDataManager] updtaTime:model];
      return  [NSString stringWithFormat:@"时间: %@ 时区:0",[date formatHMSYMD]];
    }
}





@end
