//
//  SPAccessoryTableViewInfo.m
//  SmartPlug
//
//  Created by patpat on 2017/11/7.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPAccessoryTableViewInfo.h"

@implementation SPAccessoryTableViewRowObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 0.0f;
        self.title = @"";
        self.value = @"";
        self.type = SPAccessoryTableViewRowTypeCommon;
    }
    return self;
}

@end

@implementation SPAccessoryTableViewSectionObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerHeight = 10.0f;
    }
    return self;
}
@end

@implementation SPAccessoryTableViewInfo

- (void)configureData:(NSMutableArray *)data
            accessory:(HMAccessory*)accessory
   containerViewWidth:(float)width
{
    if (!accessory) {
        return;
    }
    [data removeAllObjects];
   
    /*=== status ===*/ //
    SPAccessoryTableViewSectionObject *sectionObject = [[SPAccessoryTableViewSectionObject alloc]init];
    sectionObject.type = SPAccessoryTableViewSectionTypeStatus;
    sectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:sectionObject];
    
    SPAccessoryTableViewRowObject *rowObject = [[SPAccessoryTableViewRowObject alloc]init];
    rowObject.height = 60;
    rowObject.type = SPAccessoryTableViewRowTypeStatus;
    [sectionObject.rows addObject:rowObject];
    
    rowObject = [[SPAccessoryTableViewRowObject alloc]init];
    rowObject.height = 60;
    rowObject.type = SPAccessoryTableViewRowTypePower;
    [sectionObject.rows addObject:rowObject];
    
    rowObject = [[SPAccessoryTableViewRowObject alloc]init];
    rowObject.height = 60;
    rowObject.type = SPAccessoryTableViewRowTypeCommon;
    [sectionObject.rows addObject:rowObject];

    
    /*=== accessory name ===*/
    SPAccessoryTableViewSectionObject* nameSectionObject = [[SPAccessoryTableViewSectionObject alloc]init];
    nameSectionObject.type = SPAccessoryTableViewSectionTypeName;
    nameSectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:nameSectionObject];
    
    
    SPAccessoryTableViewRowObject *nameRowObject = [[SPAccessoryTableViewRowObject alloc]init];
    nameRowObject.height = 60;
    nameRowObject.type = SPAccessoryTableViewRowTypeCommon;
    [nameSectionObject.rows addObject:nameRowObject];
    
    /*=== accessory name ===*/
    SPAccessoryTableViewSectionObject* serviceSectionObject = [[SPAccessoryTableViewSectionObject alloc]init];
    serviceSectionObject.type = SPAccessoryTableViewSectionTypeService;
    serviceSectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:serviceSectionObject];
    
    SPAccessoryTableViewRowObject *serviceRowObject = [[SPAccessoryTableViewRowObject alloc]init];
    serviceRowObject.height = 40;
    serviceRowObject.type = SPAccessoryTableViewRowTypeAccessory;
    [serviceSectionObject.rows addObject:serviceRowObject];
    
    SPAccessoryTableViewRowObject *recognizeRowObject = [[SPAccessoryTableViewRowObject alloc]init];
    recognizeRowObject.height = 70;
    recognizeRowObject.type = SPAccessoryTableViewRowTypeRecognizeAccessory;
    [serviceSectionObject.rows addObject:recognizeRowObject];
    
}

@end
