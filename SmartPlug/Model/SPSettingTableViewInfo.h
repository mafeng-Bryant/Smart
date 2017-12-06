//
//  SPSettingTableViewInfo.h
//  SmartPlug
//
//  Created by patpat on 2017/12/1.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HomeKit/HomeKit.h>

typedef enum {
    SPSettingTableViewSectionTypeInfo,//设备信息组
    SPSettingTableViewSectionTypeVersion,//设备升级组
    SPSettingTableViewSectionTypeSynchTime//设备同步时间组
}SPSettingTableViewSectionType;

typedef enum {
    SPSettingTableViewRowTypeCommon, //行类别一样,不用操作的统统用这个类型
    SPSettingTableViewRowTypeRegnize,//识别
    SPSettingTableViewRowTypeUpdataVersion,//升级配件
    SPSettingTableViewRowTypeUpdateTime//同步时间
}SPSettingTableViewRowType;

@interface SPSettingTableViewRowObject : NSObject
@property(nonatomic,assign)SPSettingTableViewRowType type;
@property(nonatomic,assign)float height;
@property(nonatomic,strong)id object; //object
@property(nonatomic,strong)NSString *title;//title
@property(nonatomic,strong)NSString *value;//value
@end


@interface SPSettingTableViewSectionObject : NSObject
@property(nonatomic,assign)SPSettingTableViewSectionType type;
@property(nonatomic,strong)NSMutableArray *rows;
@property(nonatomic,assign)float headerHeight;
@property(nonatomic,assign)float footerHeight;
@end

@interface SPSettingTableViewInfo : NSObject

- (void)configureData:(NSMutableArray *)data
            accessory:(HMAccessory*)accessory
   containerViewWidth:(float)width;

@end
