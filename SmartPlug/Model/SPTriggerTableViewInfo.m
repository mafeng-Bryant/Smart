//
//  SPTriggerTableViewInfo.m
//  SmartPlug
//
//  Created by patpat on 2017/11/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTriggerTableViewInfo.h"
#import "Help.h"
#import "SPActionSetModel.h"

@implementation SPTriggerTableViewRowObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 0.0f;
        self.title = @"";
        self.value = @"";
        self.type = SPTriggerRowTypeDefalut;
    }
    return self;
}

@end

@implementation SPTriggerTableViewSectionObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerHeight = 10.0f;
    }
    return self;
}
@end

@interface SPTriggerTableViewInfo()


@end

@implementation SPTriggerTableViewInfo

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.sceneDatas = [NSMutableArray array];
        self.chooseSceneDatas = [NSMutableArray array];
        self.originChooseSceneDatas = [NSMutableArray array];
        self.isSure = NO;
        self.isOriginSure = NO;
        self.chooseTimeType = SPTriggerTimeTypeNone;
        self.originChooseTimeType = SPTriggerTimeTypeNone;
    }
    return self;
}

-(NSDateComponents *)dateComponent
{
    if (!_dateComponent) {
        _dateComponent = [[NSDateComponents alloc]init];
        [_dateComponent setWeekOfMonth:0];
        [_dateComponent setDay:0];
        [_dateComponent setHour:0];
        [_dateComponent setMinute:0];
    }
    return _dateComponent;
}
- (void)configureData:(NSMutableArray *)data
   containerViewWidth:(float)width
{
    [data removeAllObjects];
    
    /*=== Trigger name ===*/ //
    SPTriggerTableViewSectionObject *sectionObject = [[SPTriggerTableViewSectionObject alloc]init];
    sectionObject.type = SPHelpSectionTypeTriggerName;
    sectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:sectionObject];
    
    //默认行
    SPTriggerTableViewRowObject *rowObject = [[SPTriggerTableViewRowObject alloc]init];
    rowObject.height = VMargin1;
    rowObject.type = SPTriggerRowTypeDefalut;
    [sectionObject.rows addObject:rowObject];
    
    
    /*=== Enable Settings ===*/ //
    SPTriggerTableViewSectionObject *settingSectionObject = [[SPTriggerTableViewSectionObject alloc]init];
    settingSectionObject.type = SPTriggerSectionTypeEnableSettings;
    settingSectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:settingSectionObject];
    
    rowObject = [[SPTriggerTableViewRowObject alloc]init];
    rowObject.height = VMargin1;
    rowObject.type = SPTriggerRowTypeDefalut;
    [settingSectionObject.rows addObject:rowObject];
    
    
    /*=== Scenes==*/ //
    SPTriggerTableViewSectionObject *sceneSectionObject = [[SPTriggerTableViewSectionObject alloc]init];
    sceneSectionObject.type = SPHelpSectionTypeScenes;
    sceneSectionObject.rows = [[NSMutableArray alloc]init];
    [data addObject:sceneSectionObject];
    
    rowObject = [[SPTriggerTableViewRowObject alloc]init];
    rowObject.height = VMargin1;
    rowObject.type = SPTriggerRowTypeDefalut;
    [sceneSectionObject.rows addObject:rowObject];
    
    if (self.sceneDatas.count>0) {
         for (SPActionSetModel* model in self.sceneDatas) {
            rowObject = [[SPTriggerTableViewRowObject alloc]init];
            rowObject.height = VMargin60;
            rowObject.type = SPTriggerRowTypeNormal;
            rowObject.model = model;
            [sceneSectionObject.rows addObject:rowObject];
             if ([self.chooseModel.actionSet.name isEqualToString:model.actionSet.name]) {
                 [self.chooseSceneDatas addObject:model];
                 [self.originChooseSceneDatas addObject:model];
             }
         }
    }

      if (self.type == SPTriggerTypeTime) {
        /*=== Time Date ===*/
        SPTriggerTableViewSectionObject *timeDateSectionObject = [[SPTriggerTableViewSectionObject alloc]init];
        timeDateSectionObject.type = SPHelpSectionTypeTimeAndDate;
        timeDateSectionObject.rows = [[NSMutableArray alloc]init];
        [data addObject:timeDateSectionObject];
        
        rowObject = [[SPTriggerTableViewRowObject alloc]init];
        rowObject.height = UITableViewAutomaticDimension;
        rowObject.type = SPTriggerRowTypeChooseTime;
        [timeDateSectionObject.rows addObject:rowObject];
        
        /*=== Choose Time ===*/ //
        SPTriggerTableViewSectionObject *chooseDateSectionObject = [[SPTriggerTableViewSectionObject alloc]init];
        chooseDateSectionObject.type = SPHelpSectionTypeDate;
        chooseDateSectionObject.rows = [[NSMutableArray alloc]init];
        [data addObject:chooseDateSectionObject];
        
        for (int i = 0; i < 3; i++) {
            rowObject = [[SPTriggerTableViewRowObject alloc]init];
            rowObject.height = VMargin40;
            rowObject.type = SPTriggerRowTypeNormal;
            rowObject.title = [[self getTimes] objectAtIndex:i];
            rowObject.timeType = [self getTimeType:i];
            if (self.chooseTimeType == SPTriggerTimeTypeEveryHour) {
                if (rowObject.timeType == SPTriggerTimeTypeEveryHour) {
                    self.chooseRowObject = rowObject;
                    self.originchooseRowObject = rowObject;
                }
            }else if (self.chooseTimeType == SPTriggerTimeTypeEveryDay){
                if (rowObject.timeType == SPTriggerTimeTypeEveryDay) {
                    self.chooseRowObject = rowObject;
                    self.originchooseRowObject = rowObject;
                }
            }else if (self.chooseTimeType == SPTriggerTimeTypeEveryWeek){
                if (rowObject.timeType == SPTriggerTimeTypeEveryWeek) {
                    self.chooseRowObject = rowObject;
                    self.originchooseRowObject = rowObject;
                }
            }
            [chooseDateSectionObject.rows addObject:rowObject];
        }
    }
    
    if (self.type == SPTriggerTypeSpecial) {
        
        /*=== Special ===*/
        SPTriggerTableViewSectionObject *specailSectionObject = [[SPTriggerTableViewSectionObject alloc]init];
        specailSectionObject.type = SPHelpSectionTypeSpecial;
        specailSectionObject.rows = [[NSMutableArray alloc]init];
        [data addObject:specailSectionObject];
        
        rowObject = [[SPTriggerTableViewRowObject alloc]init];
        rowObject.height = VMargin1;
        rowObject.type = SPTriggerRowTypeDefalut;
        [specailSectionObject.rows addObject:rowObject];
        
        /*=== Condition ===*/ //
        SPTriggerTableViewSectionObject *condotionSectionObject = [[SPTriggerTableViewSectionObject alloc]init];
        condotionSectionObject.type = SPHelpSectionTypeCondition;
        condotionSectionObject.rows = [[NSMutableArray alloc]init];
        [data addObject:condotionSectionObject];
        
        rowObject = [[SPTriggerTableViewRowObject alloc]init];
        rowObject.height = VMargin1;
        rowObject.type = SPTriggerRowTypeDefalut;
        [condotionSectionObject.rows addObject:rowObject];
        
    }
}

- (NSArray*)getTimes
{
    return @[@"每小时",@"每天",@"每星期"];
}

- (SPTriggerTimeType)getTimeType:(NSInteger)index
{
    if (index == 0) {
        return SPTriggerTimeTypeEveryHour;
    }else if (index == 1){
        return SPTriggerTimeTypeEveryDay;
    }else if (index == 2){
        return SPTriggerTimeTypeEveryWeek;
    }
    return SPTriggerTimeTypeNone;
}


@end
