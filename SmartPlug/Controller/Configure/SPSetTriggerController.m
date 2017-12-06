//
//  SPSetTriggerController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPSetTriggerController.h"
#import "SPTitleView.h"
#import "SPTriggerDataSource.h"
#import "SPActionSetModel.h"
#import "Help.h"
#import "MBProgressHUD.h"


@interface SPSetTriggerController ()<HMHomeManagerDelegate>
{
    SPTriggerType _type;
}

@property (nonatomic,strong) SPTriggerDataSource* dataSource;
@property (nonatomic,strong) SPTriggerTableViewInfo* tableViewInfo;
@property (strong, nonatomic)HMHomeManager * homeManager;
@property (nonatomic,strong) HMHome* currentHome;
@property (nonatomic,strong) HMTimerTrigger* trigger;
@property (nonatomic,strong) SPConfigureZoneModel* mode;

@end

@implementation SPSetTriggerController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
                         model:(SPConfigureZoneModel*)model
                          type:(SPTriggerType)type
                 operationType:(SPTriggerOperationType)operationType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _type = type;
        _operationType = operationType;
        _mode = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleViewText];
    [self setLeftItem];
    [self setRightItem];
    [self dataSource];
}

#pragma mark HMHomeManagerDelegate

- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager
{
    [self setTitleViewText];
    [_dataSource refreshUI];
}

- (void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager
{
    [self setTitleViewText];
    [_dataSource refreshUI];
}

#pragma mark set and get method

-(SPTriggerDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[SPTriggerDataSource alloc]initWithTableView:self.tableView tableViewInfo:self.tableViewInfo];
    }
    return _dataSource;
}

-(SPTriggerTableViewInfo *)tableViewInfo
{
    if (!_tableViewInfo) {
        _tableViewInfo = [[SPTriggerTableViewInfo alloc]init];
        _tableViewInfo.isOriginSure = _mode.trigger.enabled?YES:NO;
        _tableViewInfo.isSure = _mode.trigger.enabled?YES:NO;
        _tableViewInfo.originTriggerName = _mode.trigger.name;
        _tableViewInfo.triggerName = _mode.trigger.name;
        _tableViewInfo.dateComponent = _mode.trigger.recurrence;
        [self setTimeDateComponent];
    }
    return _tableViewInfo;
}

- (void)setTimeDateComponent
{
    if (_mode.trigger.recurrence.weekOfMonth > 0) {
        _tableViewInfo.chooseTimeType = SPTriggerTimeTypeEveryWeek;
        _tableViewInfo.originChooseTimeType = SPTriggerTimeTypeEveryWeek;
    }else if (_mode.trigger.recurrence.day>0){
        _tableViewInfo.chooseTimeType = SPTriggerTimeTypeEveryDay;
        _tableViewInfo.originChooseTimeType = SPTriggerTimeTypeEveryDay;
    }else if (_mode.trigger.recurrence.hour>0){
        _tableViewInfo.chooseTimeType = SPTriggerTimeTypeEveryHour;
        _tableViewInfo.originChooseTimeType = SPTriggerTimeTypeEveryHour;
    }else {
        _tableViewInfo.chooseTimeType = SPTriggerTimeTypeNone;
        _tableViewInfo.originChooseTimeType = SPTriggerTimeTypeNone;
    }
    //set scenes
    if (_mode.trigger.actionSets.count>0) {
        for (HMActionSet* set in _mode.trigger.actionSets) {
            _tableViewInfo.actionSet = set;
        }
    }
}

- (HMHomeManager *)homeManager
{
    if (_homeManager == nil) {
        _homeManager =  [HMHomeManager new];
        _homeManager.delegate = self;
    }
    return _homeManager;
}

- (void)setTitleViewText
{
    NSString* title = @"家";
    for (HMHome* home in self.homeManager.homes) {
        if (home.isPrimary) {
            _currentHome = home;
            title = home.name;
        }
    }
    [self.tableViewInfo.sceneDatas removeAllObjects];
    //get action set data
    if (_currentHome) {
        for (HMActionSet* set in _currentHome.actionSets) {
            SPActionSetModel* model = [[SPActionSetModel alloc]init];
            if ([set.actionSetType isEqual:HMActionSetTypeUserDefined]) {
                model.type = SPActionSetTypeCustom;
            }else if ([set.actionSetType isEqual:HMActionSetTypeWakeUp]){
                model.type = SPActionSetTypeGoodMorning;
            }else if ([set.actionSetType isEqual:HMActionSetTypeHomeDeparture]){
                model.type = SPActionSetTypeGoOut;
            }else if ([set.actionSetType isEqual:HMActionSetTypeHomeArrival]){
                model.type = SPActionSetTypeComeBack;
            }else if ([set.actionSetType isEqual:HMActionSetTypeSleep]){
                model.type = SPActionSetTypeGoodNight;
            }
            model.actionSet = set;
            [self.tableViewInfo.sceneDatas addObject:model];
        }
        for ( SPActionSetModel* model in self.tableViewInfo.sceneDatas) {
            if ([model.actionSet.name isEqualToString:self.tableViewInfo.actionSet.name]) {
                self.tableViewInfo.chooseModel = model;
                break;
            }
        }
    }
    SPTitleView* view = [[SPTitleView alloc]initWithFrame:CGRectZero title:@"新的触发器"];
    self.navigationItem.titleView = view;
}

- (void)setLeftItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 24, 24);
    [btn addTarget:self action:@selector(closeAction:)
  forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:14];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setRightItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 21, 21);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:14];
    [btn addTarget:self action:@selector(addTriggerAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addTriggerAction:(UIButton*)btn
{
    [self.tableView endEditing:YES];
    
    if (_operationType == SPTriggerOperationTypeAdd) {
        if ([self.tableViewInfo.triggerName length]<=0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"请输入触发器名称";
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
            return;
        }
        
        if (!self.tableViewInfo.chooseDate) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"请选择时间";
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
            return;
        }
    }
    
    [self setDateCompont];
    __weak typeof (self) weakSelf = self;
    if (_operationType == SPTriggerOperationTypeAdd) { //添加触发器
        HMTimerTrigger*  trigger = [[HMTimerTrigger alloc]initWithName:self.tableViewInfo.triggerName fireDate:self.tableViewInfo.chooseDate timeZone:nil recurrence:(self.tableViewInfo.chooseTimeType == SPTriggerTimeTypeNone)?nil:self.tableViewInfo.dateComponent recurrenceCalendar:[NSCalendar currentCalendar]];
        self.trigger = trigger;
        if (self.currentHome) {
            [self.currentHome addTrigger:trigger completionHandler:^(NSError * _Nullable error) {
                if (!error) {
                    if (weakSelf.tableViewInfo.chooseSceneDatas.count>0) {
                        //添加动作集到触发器。
                        SPActionSetModel* model = [weakSelf.tableViewInfo.chooseSceneDatas firstObject];
                        [trigger addActionSet:model.actionSet completionHandler:^(NSError * _Nullable error) {
                            if (!error) {
                                //是否启动触发器
                                 if (weakSelf.tableViewInfo.isSure) {
                                    [weakSelf.trigger enable:YES completionHandler:^(NSError * _Nullable error) {
                                        if (!error) {
                                            NSLog(@"触发器启动成功");
                                        }
                                        [weakSelf closeAction:nil];
                                    }];
                                }
                            }else {
                                [weakSelf closeAction:nil];
                            }
                        }];
                    }
                }else {
                    [weakSelf closeAction:nil];
                }
            }];
        }
    }else if (_operationType == SPTriggerOperationTypeEdit) { //编辑触发器
        
        // 1.队列组
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        //先判断是否需要更新触发器的名称
        if (![self.tableViewInfo.triggerName isEqualToString:self.tableViewInfo.originTriggerName]) {
            dispatch_group_async(group, queue, ^{
                [_mode.trigger updateName:self.tableViewInfo.triggerName completionHandler:^(NSError * _Nullable error) {
                    if (!error) {
                        NSLog(@"更新触发器的名称成功");
                    }
                }];
           });
       }
        
        //判断是否需要更新触发器的场景
        if (self.tableViewInfo.originChooseSceneDatas.count>0) {
            SPActionSetModel* model = [self.tableViewInfo.originChooseSceneDatas firstObject];
            if (self.tableViewInfo.chooseSceneDatas.count == 0) {
                 dispatch_group_async(group, queue, ^{
                    [_mode.trigger enable:NO completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            NSLog(@"设置触发器是否自动启动成功");
                         }
                    }];
                });
                dispatch_group_async(group, queue, ^{
                    //移除触发器的动作集
                    [_mode.trigger removeActionSet:[self getActionSet:model] completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            NSLog(@"移除触发器的动作集");
                        }
                    }];
                });
        }else {
                SPActionSetModel* actionModel = [self.tableViewInfo.chooseSceneDatas firstObject];
                if (![actionModel.actionSet.name isEqualToString:model.actionSet.name]) {
                    dispatch_group_async(group, queue, ^{
                        //触发器添加新的动作集
                        [_mode.trigger removeActionSet:[self getActionSet:model] completionHandler:^(NSError * _Nullable error) {
                            if (!error) {
                                NSLog(@"移除触发器的动作集");
                                [_mode.trigger addActionSet:actionModel.actionSet completionHandler:^(NSError * _Nullable                                                                                                  error) {
                                    if (!error) {
                                         NSLog(@"添加触发器的动作集");
                                    }
                                }];
                            }
                        }];
                   });
                    //判断是不是要关闭触发器
                    if (self.tableViewInfo.isOriginSure != self.tableViewInfo.isSure) {
                        dispatch_group_async(group, queue, ^{
                            [_mode.trigger enable:self.tableViewInfo.isSure completionHandler:^(NSError * _Nullable error) {
                                if (!error) {
                                    NSLog(@"设置触发器是否自动启动成功");
                                }
                            }];
                       });
                    }
                }else {
                    //判断是不是要关闭触发器
                    if (self.tableViewInfo.isOriginSure != self.tableViewInfo.isSure) {
                        dispatch_group_async(group, queue, ^{
                            [_mode.trigger enable:self.tableViewInfo.isSure completionHandler:^(NSError * _Nullable error) {
                                if (!error) {
                                    NSLog(@"设置触发器是否自动启动成功");
                                }
                            }];
                        });
                    }
                }
            }
        } else {
            if (self.tableViewInfo.chooseSceneDatas.count>0) {
                //触发器添加新的动作集
                SPActionSetModel* actionModel = [self.tableViewInfo.chooseSceneDatas firstObject];
                dispatch_group_async(group, queue, ^{
                    [_mode.trigger addActionSet:actionModel.actionSet completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            NSLog(@"添加触发器的动作集");
                        }
                    }];
                });
            }
        }
        
        //判断是否需要更新触发器的周期
        if (self.tableViewInfo.originchooseRowObject != self.tableViewInfo.chooseRowObject) {
            [self setDateCompont];
            if (self.tableViewInfo.chooseTimeType == SPTriggerTimeTypeNone) {
                dispatch_group_async(group, queue, ^{
                    [_mode.trigger updateRecurrence:nil completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            NSLog(@"触发器周期更新成功");
                        }
                    }];
                });
            }else {
                dispatch_group_async(group, queue, ^{
                    [_mode.trigger updateRecurrence:self.tableViewInfo.dateComponent completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            self.tableViewInfo.chooseTimeType = SPTriggerTimeTypeNone;
                            NSLog(@"触发器周期更新成功");
                        }
                    }];
                });
            }
        }
        //全部更新完成调用
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self closeAction:nil];
            });
        });
  }
}

- (void)setDateCompont
{
    if (self.tableViewInfo.chooseRowObject) {
        if (self.tableViewInfo.chooseRowObject.timeType == SPTriggerTimeTypeEveryHour) {
            self.tableViewInfo.chooseTimeType = SPTriggerTimeTypeEveryHour;
            [self.tableViewInfo.dateComponent setWeekOfMonth:0];
            [self.tableViewInfo.dateComponent setDay:0];
            [self.tableViewInfo.dateComponent setHour:1];
            [self.tableViewInfo.dateComponent setMinute:0];
        }else if (self.tableViewInfo.chooseRowObject.timeType == SPTriggerTimeTypeEveryDay){
            self.tableViewInfo.chooseTimeType = SPTriggerTimeTypeEveryDay;
            [self.tableViewInfo.dateComponent setWeekOfMonth:0];
            [self.tableViewInfo.dateComponent setDay:1];
            [self.tableViewInfo.dateComponent setHour:0];
            [self.tableViewInfo.dateComponent setMinute:0];
        }else if (self.tableViewInfo.chooseRowObject.timeType == SPTriggerTimeTypeEveryWeek){
            self.tableViewInfo.chooseTimeType = SPTriggerTimeTypeEveryWeek;
            [self.tableViewInfo.dateComponent setWeekOfMonth:1];
            [self.tableViewInfo.dateComponent setDay:0];
            [self.tableViewInfo.dateComponent setHour:0];
            [self.tableViewInfo.dateComponent setMinute:0];
        }else {
            self.tableViewInfo.chooseTimeType = SPTriggerTimeTypeNone;
            [self.tableViewInfo.dateComponent setWeekOfMonth:0];
            [self.tableViewInfo.dateComponent setDay:0];
            [self.tableViewInfo.dateComponent setHour:0];
            [self.tableViewInfo.dateComponent setMinute:0];
         }
    }else {
        self.tableViewInfo.chooseTimeType = SPTriggerTimeTypeNone;
        [self.tableViewInfo.dateComponent setWeekOfMonth:0];
        [self.tableViewInfo.dateComponent setDay:0];
        [self.tableViewInfo.dateComponent setHour:0];
        [self.tableViewInfo.dateComponent setMinute:0];
    }
}

- (HMActionSet*)getActionSet:(SPActionSetModel*)model
{
    HMActionSet* _set;
    for (HMActionSet* set in _mode.trigger.actionSets) {
        if ([set.name isEqualToString:model.actionSet.name]) {
            _set = set;
            break;
        }
    }
    return _set;
}

- (void)callBack
{
    if (self.universalDelegate && [self.universalDelegate respondsToSelector:@selector(callBack:withObject:)]) {
        [self.universalDelegate callBack:self withObject:nil];
    }
}

- (void)closeAction:(UIButton*)btn
{
    [self callBack];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
