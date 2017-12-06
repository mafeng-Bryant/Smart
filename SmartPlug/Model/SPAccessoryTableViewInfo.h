//
//  SPAccessoryTableViewInfo.h
//  SmartPlug
//
//  Created by patpat on 2017/11/7.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HomeKit/HomeKit.h>

typedef enum {
    SPAccessoryTableViewSectionTypeStatus,
    SPAccessoryTableViewSectionTypeName,
    SPAccessoryTableViewSectionTypeService
}SPAccessoryTableViewSectionType;

typedef enum {
     SPAccessoryTableViewRowTypeStatus,//状态
     SPAccessoryTableViewRowTypePower,
    SPAccessoryTableViewRowTypeCommon,
    SPAccessoryTableViewRowTypeAccessory,//设备
    SPAccessoryTableViewRowTypeRecognizeAccessory,//识别设备
}SPAccessoryTableViewRowType;

@interface SPAccessoryTableViewRowObject : NSObject
@property(nonatomic,assign)SPAccessoryTableViewRowType type;
@property(nonatomic,assign)float height;
@property(nonatomic,strong)id object; //object
@property(nonatomic,assign)BOOL isOn;//状态
@property(nonatomic,strong)NSString *title;//title
@property(nonatomic,strong)NSString *value;//value
@end

@interface SPAccessoryTableViewSectionObject : NSObject
@property(nonatomic,assign)SPAccessoryTableViewSectionType type;
@property(nonatomic,strong)NSMutableArray *rows;
@property(nonatomic,assign)float headerHeight;
@property(nonatomic,assign)float footerHeight;
@end

@interface SPAccessoryTableViewInfo : NSObject

- (void)configureData:(NSMutableArray *)data
            accessory:(HMAccessory*)accessory
   containerViewWidth:(float)width;

@end
