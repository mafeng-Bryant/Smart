//
//  SPSetTriggerController.h
//  SmartPlug
//
//  Created by patpat on 2017/11/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPBaseController.h"
#import "SPConfigureZoneModel.h"

typedef enum
{
 SPTriggerTypeTime,//时间触发器
 SPTriggerTypeSpecial//特征触发器
}SPTriggerType;

typedef enum
{
    SPTriggerOperationTypeAdd,//添加触发器
    SPTriggerOperationTypeEdit//编辑触发器
}SPTriggerOperationType;

@interface SPSetTriggerController : SPBaseController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) SPTriggerOperationType operationType;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
                         model:(SPConfigureZoneModel*)model
                          type:(SPTriggerType)type
                 operationType:(SPTriggerOperationType)operationType;

@end
