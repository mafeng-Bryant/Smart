//
//  SPTriggerTableViewInfo.h
//  SmartPlug
//
//  Created by patpat on 2017/11/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPSetTriggerController.h"
#import <HomeKit/HomeKit.h>

@class SPActionSetModel;

typedef enum {
    SPHelpSectionTypeTriggerName,//触发器名称
    SPTriggerSectionTypeEnableSettings,//启用设定
    SPHelpSectionTypeScenes,//场景
    SPHelpSectionTypeTimeAndDate,//时间和日期
    SPHelpSectionTypeDate,//重复时间
    SPHelpSectionTypeSpecial,//特征
    SPHelpSectionTypeCondition//条件
}SPTriggerSectionType;

typedef enum {
    SPTriggerRowTypeDefalut,//默认行
    SPTriggerRowTypeNormal,//如场景的行...
    SPTriggerRowTypeChooseTime
}SPTriggerRowType;

typedef enum
{
 SPTriggerTimeTypeNone,//默认值
 SPTriggerTimeTypeEveryHour,//每小时
 SPTriggerTimeTypeEveryDay,//每天
 SPTriggerTimeTypeEveryWeek//每星期
}SPTriggerTimeType;

@interface SPTriggerTableViewRowObject : NSObject
@property(nonatomic,assign)SPTriggerRowType type;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,strong)id object; //object
@property(nonatomic,strong)NSString *title;//title
@property(nonatomic,strong)NSString *value;//value
@property(nonatomic,strong)SPActionSetModel* model;
@property(nonatomic,assign)SPTriggerTimeType timeType;
@property(nonatomic,strong)HMActionSet* actionSet;//动作集

@end

@interface SPTriggerTableViewSectionObject : NSObject
@property(nonatomic,assign)SPTriggerSectionType type;
@property(nonatomic,strong)NSMutableArray *rows;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,assign)float headerHeight;
@property(nonatomic,assign)float footerHeight;
@property(nonatomic,strong)NSString* uuId;

@end

@interface SPTriggerTableViewInfo : NSObject
@property (nonatomic,assign) SPTriggerType type;
@property (nonatomic,strong) NSMutableArray* sceneDatas;
@property (nonatomic,assign) SPTriggerTimeType chooseTimeType;//选择的时间类型
@property (nonatomic,assign) SPTriggerTimeType originChooseTimeType;//原始的选择的时间类型
@property (nonatomic,strong) NSMutableArray* originChooseSceneDatas;//原始的选择的场景
@property (nonatomic,strong) NSMutableArray* chooseSceneDatas;//选择的场景
@property (nonatomic,strong) NSString* triggerName;//触发器的名称
@property (nonatomic,strong) NSString* originTriggerName;//原始的触发器名称
@property (nonatomic,assign) BOOL isSure;//是否启用设定
@property (nonatomic,assign) BOOL isOriginSure;//原始的触发器启动判断
@property (nonatomic,strong) NSDate* chooseDate;//选择时间
@property (nonatomic,strong) NSDateComponents *dateComponent;
@property (nonatomic,strong) SPTriggerTableViewRowObject* chooseRowObject;
@property (nonatomic,strong) SPTriggerTableViewRowObject* originchooseRowObject;
@property (nonatomic,strong) HMActionSet* actionSet;//动作集
@property (nonatomic,strong) SPActionSetModel* chooseModel;

- (void)configureData:(NSMutableArray *)data
   containerViewWidth:(float)width;

@end
