//
//  SPConfigureTableViewInfo.h
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HomeKit/HomeKit.h>

@class SPConfigureZoneModel;

typedef enum {
    SPConfigureSectionTypeUser,
    SPConfigureSectionTypeZones,
    SPConfigureSectionTypeServiceGroup,
    SPConfigureSectionTypeTriggers
}SPConfigureSectionType;

typedef enum {
    SPConfigureRowTypeDefault,
    SPConfigureRowTypeUser,
    SPConfigureRowTypeZones,//状态
    SPConfigureRowTypeService,
    SPConfigureRowTypeTriggers
}SPConfigureRowType;

@interface SPConfigureTableViewRowObject : NSObject
@property(nonatomic,assign)SPConfigureRowType type;
@property(nonatomic,assign)float height;
@property(nonatomic,strong)id object; //object
@property(nonatomic,assign)BOOL isOn;//状态
@property(nonatomic,strong)NSString *title;//title
@property(nonatomic,strong)NSString *value;//value
@property(nonatomic,strong)SPConfigureZoneModel* model;

@end

@interface SPConfigureTableViewSectionObject : NSObject
@property(nonatomic,assign)SPConfigureSectionType type;
@property(nonatomic,strong)NSMutableArray *rows;
@property(nonatomic,assign)float headerHeight;
@property(nonatomic,assign)float footerHeight;
@end


@interface SPConfigureTableViewInfo : NSObject

- (void)configureData:(NSMutableArray *)data
                 home:(HMHome*)currentHome
   containerViewWidth:(float)width;

@end
