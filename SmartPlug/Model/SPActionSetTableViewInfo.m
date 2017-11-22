//
//  SPActionSetTableViewInfo.m
//  SmartPlug
//
//  Created by patpat on 2017/11/10.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPActionSetTableViewInfo.h"
#import "Help.h"

@implementation SPActionSetTableViewRowObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 0.0f;
        self.title = @"";
        self.value = @"";
        self.type = SPActionSetRowTypeOpen;
    }
    return self;
}

@end

@implementation SPActionSetTableViewSectionObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerHeight = 10.0f;
    }
    return self;
}
@end



@implementation SPActionSetTableViewInfo

- (void)configureData:(NSMutableArray *)data
                 home:(HMHome*)currentHome
                model:(SPActionSetModel*)model
              service:(HMService*)service
   containerViewWidth:(float)width
{
    [data removeAllObjects];
    
    /*=== header ===*/ //
    SPActionSetTableViewSectionObject *sectionObject = [[SPActionSetTableViewSectionObject alloc]init];
    sectionObject.type = SPActionSetSectionTypeHeader;
    sectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:sectionObject];
    
    for (HMAccessory* accessory in currentHome.accessories) {
        if (service.characteristics.count>0) {
            for (int i = 0; i<2; i++) {
                SPActionSetTableViewRowObject *rowObject = [[SPActionSetTableViewRowObject alloc]init];
                rowObject.height = VMargin50;
                rowObject.accessory = accessory;
                sectionObject.title = accessory.name;
                rowObject.hasValue = (model.actionSet.actions.count>0)?YES:NO;
                rowObject.type = (i==0)?SPActionSetRowTypeOpen:SPActionSetRowTypeClose;
                if (i==0) {
                    HMCharacteristicWriteAction* action = [[HMCharacteristicWriteAction alloc]initWithCharacteristic:service.characteristics[0] targetValue:@1];
                    rowObject.action = action;
                }else {
                    HMCharacteristicWriteAction* action = [[HMCharacteristicWriteAction alloc]initWithCharacteristic:service.characteristics[0] targetValue:@0];
                    rowObject.action = action;
                }
                [sectionObject.rows addObject:rowObject];
            }
        }
     }
}

@end
