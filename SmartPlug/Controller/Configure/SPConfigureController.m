//
//  SPConfigureController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPConfigureController.h"
#import <HomeKit/HomeKit.h>
#import "SPTitleView.h"
#import "SPConfigureDataSource.h"
#import "SPConfigureTableViewInfo.h"
#import "SPConfigureZoneModel.h"
#import "SPSetTriggerController.h"
#import "SPBaseNavigationController.h"
#import "MJRefresh.h"

@interface SPConfigureController ()<HMHomeManagerDelegate,SPTableViewDataSourceAccessory,UniversalDelegate>
@property (nonatomic,strong) HMHomeManager* homeManager;
@property (nonatomic,strong) HMHome* currentHome;
@property (nonatomic,strong) SPConfigureDataSource* dataSource;
@property (nonatomic,strong) SPConfigureTableViewInfo* tableViewInfo;

@end

@implementation SPConfigureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleViewText];
    [self dataSource];
    [self setRefrefesh];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark set and get method

-(SPConfigureDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[SPConfigureDataSource alloc]initWithTableView:self.tableView
                                                          currentHome:self.currentHome
                                                        tableViewInfo:self.tableViewInfo];
        _dataSource.dataSourceAccessory = self;
    }
    return _dataSource;
}

-(SPConfigureTableViewInfo *)tableViewInfo
{
    if (!_tableViewInfo) {
        _tableViewInfo = [[SPConfigureTableViewInfo alloc]init];
    }
    return _tableViewInfo;
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
    self.navigationItem.titleView = [[SPTitleView alloc]initWithFrame:CGRectZero title:title];
}

#pragma mark HMHomeManagerDelegate

- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager
{
    [self setTitleViewText];
    [_dataSource setCurrentChooseHome:_currentHome];
}

- (void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager
{
    [self setTitleViewText];
    [_dataSource setCurrentChooseHome:_currentHome];
}

- (void)hiddenTitleView
{
    self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)showTitleView
{
    [self setTitleViewText];
}

- (void)addZonesCallBlock:(void(^)(BOOL result))block
{
    UIAlertController *inputNameAlter = [UIAlertController alertControllerWithTitle:@"新区域" message:@"请输入区域名称" preferredStyle:1];
    [inputNameAlter addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"区域名称";
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"添加" style:0 handler:^(UIAlertAction * _Nonnull action) {
        NSString *name =inputNameAlter.textFields.firstObject.text;
        [self.currentHome addZoneWithName:name completionHandler:^(HMZone * _Nullable zone, NSError * _Nullable error) {
            if (!error) {
                block(YES);
            }
       }];
    }];
    [inputNameAlter addAction:action1];
    [inputNameAlter addAction:action2];
    [self presentViewController:inputNameAlter animated:YES completion:^{}];
}

- (void)addServiceGroup:(void(^)(BOOL result))block
{
    UIAlertController *inputNameAlter = [UIAlertController alertControllerWithTitle:@"新服务组" message:@"请输入服务组名称" preferredStyle:1];
    [inputNameAlter addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"服务组";
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"添加" style:0 handler:^(UIAlertAction * _Nonnull action) {
        NSString *name =inputNameAlter.textFields.firstObject.text;
        [self.currentHome addServiceGroupWithName:name completionHandler:^(HMServiceGroup * _Nullable group, NSError * _Nullable error) {
            if (!error) {
                block(YES);
            }
        }];
    }];
    [inputNameAlter addAction:action1];
    [inputNameAlter addAction:action2];
    [self presentViewController:inputNameAlter animated:YES completion:^{}];
}

- (void)addTrigger:(void(^)(BOOL result))block
{
    NSArray* operations = [self getTriggers];
    UIAlertController* homeList = [UIAlertController alertControllerWithTitle:@"" message:@"添加时间触发器" preferredStyle:0];
    for (int a = 0; a<operations.count; a++) {
        NSString* name = operations[a];
        UIAlertAction* action1 = [UIAlertAction actionWithTitle:name style:0 handler:^(UIAlertAction * _Nonnull action) {
            if ([action.title isEqualToString:@"时间触发器"]) {
                SPSetTriggerController* vc = [[SPSetTriggerController alloc]initWithNibName:@"SPSetTriggerController" bundle:nil
                                                                                      model:nil
                                                                                       type:SPTriggerTypeTime
                                              operationType:SPTriggerOperationTypeAdd];
                vc.universalDelegate = self;
                SPBaseNavigationController* na = [[SPBaseNavigationController alloc]initWithRootViewController:vc];
                [self presentViewController:na animated:YES completion:nil];
            }else if ([action.title isEqualToString:@"特征触发器"]){
                SPSetTriggerController* vc = [[SPSetTriggerController alloc]initWithNibName:@"SPSetTriggerController" bundle:nil
                                                                                      model:nil
                                                                                       type:SPTriggerTypeSpecial
                                                                              operationType:SPTriggerOperationTypeAdd];
                SPBaseNavigationController* na = [[SPBaseNavigationController alloc]initWithRootViewController:vc];
                [self presentViewController:na animated:YES completion:nil];
            }
        }];
        [homeList addAction:action1];
    }
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    [homeList addAction:action1];
    [self presentViewController:homeList animated:YES completion:^{}];
}

#pragma mark SPTableViewDataSourceAccessory

- (void)renameZoneAndDelete:(id)object callBlock:(void(^)(BOOL result))block
{
    SPConfigureZoneModel* model = (SPConfigureZoneModel*)object;
    NSArray* operations = [self getOperations];
    UIAlertController* homeList = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:0];
    for (int a = 0; a<operations.count; a++) {
        NSString* name = operations[a];
        UIAlertAction* action1 = [UIAlertAction actionWithTitle:name style:0 handler:^(UIAlertAction * _Nonnull action) {
            if ([action.title isEqualToString:@"重命名"]) {
                UIAlertController* inputNameAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入新名称" preferredStyle:1];
                [inputNameAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.text = model.zone.name;
                }];
                UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
                UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"重命名" style:0 handler:^(UIAlertAction * _Nonnull action) {
                    NSString* name = inputNameAlert.textFields.firstObject.text;
                    BOOL isExit = NO;
                    for (HMZone* zone in self.currentHome.zones) {
                        if ([zone.name isEqualToString:name]) {
                            isExit = YES;
                            break;
                        }
                    }
                    if (isExit) {
                        UIAlertController* inputNameAlert = [UIAlertController alertControllerWithTitle:@"错误" message:@"已有住家使用了相似名称" preferredStyle:1];
                        UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"好的" style:0 handler:nil];
                        [inputNameAlert addAction:action1];
                        [self presentViewController:inputNameAlert animated:YES completion:nil];
                        return ;
                    }
                    [model.zone updateName:name completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            block(YES);
                        }
                    }];
                }];
                [inputNameAlert addAction:action1];
                [inputNameAlert addAction:action2];
                [self presentViewController:inputNameAlert animated:YES completion:nil];
            }else if ([action.title isEqualToString:@"删除"]){
                [_currentHome removeZone:model.zone completionHandler:^(NSError * _Nullable error) {
                    if (!error) {
                        block(YES);
                    }
                }];
            }
        }];
        [homeList addAction:action1];
    }
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    [homeList addAction:action1];
    [self presentViewController:homeList animated:YES completion:^{}];
}

- (void)renameTriggerAndDelete:(id)object callBlock:(void (^)(BOOL))block
{
    SPConfigureZoneModel* model = (SPConfigureZoneModel*)object;
    NSArray* operations = [self getOperations];
    UIAlertController* homeList = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:0];
    for (int a = 0; a<operations.count; a++) {
        NSString* name = operations[a];
        UIAlertAction* action1 = [UIAlertAction actionWithTitle:name style:0 handler:^(UIAlertAction * _Nonnull action) {
            if ([action.title isEqualToString:@"重命名"]) {
                UIAlertController* inputNameAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入新名称" preferredStyle:1];
                [inputNameAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.text = model.trigger.name;
                }];
                UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
                UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"重命名" style:0 handler:^(UIAlertAction * _Nonnull action) {
                    NSString* name = inputNameAlert.textFields.firstObject.text;
                    BOOL isExit = NO;
                    for (HMTimerTrigger* trigger in self.currentHome.triggers) {
                        if ([trigger.name isEqualToString:name]) {
                            isExit = YES;
                            break;
                        }
                    }
                    if (isExit) {
                        UIAlertController* inputNameAlert = [UIAlertController alertControllerWithTitle:@"错误" message:@"已有住家使用了相似名称" preferredStyle:1];
                        UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"好的" style:0 handler:nil];
                        [inputNameAlert addAction:action1];
                        [self presentViewController:inputNameAlert animated:YES completion:nil];
                        return ;
                    }
                    
                    [model.trigger updateName:name completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            block(YES);
                        }
                    }];
                }];
                [inputNameAlert addAction:action1];
                [inputNameAlert addAction:action2];
                [self presentViewController:inputNameAlert animated:YES completion:nil];
            }else if ([action.title isEqualToString:@"删除"]){
                [_currentHome removeTrigger:model.trigger completionHandler:^(NSError * _Nullable error) {
                    if (!error) {
                        block(YES);
                    }
                }];
            }
        }];
        [homeList addAction:action1];
    }
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    [homeList addAction:action1];
    [self presentViewController:homeList animated:YES completion:^{}];
}

- (void)renameServiceAndDelete:(id)object callBlock:(void(^)(BOOL result))block
{
    SPConfigureZoneModel* model = (SPConfigureZoneModel*)object;
    NSArray* operations = [self getOperations];
    UIAlertController* homeList = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:0];
    for (int a = 0; a<operations.count; a++) {
        NSString* name = operations[a];
        UIAlertAction* action1 = [UIAlertAction actionWithTitle:name style:0 handler:^(UIAlertAction * _Nonnull action) {
            if ([action.title isEqualToString:@"重命名"]) {
                UIAlertController* inputNameAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入新名称" preferredStyle:1];
                [inputNameAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.text = model.serviceGroup.name;
                }];
                UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
                UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"重命名" style:0 handler:^(UIAlertAction * _Nonnull action) {
                    NSString* name = inputNameAlert.textFields.firstObject.text;
                    BOOL isExit = NO;
                    for (HMServiceGroup* service in self.currentHome.serviceGroups) {
                        if ([service.name isEqualToString:name]) {
                            isExit = YES;
                            break;
                        }
                    }
                    if (isExit) {
                        UIAlertController* inputNameAlert = [UIAlertController alertControllerWithTitle:@"错误" message:@"已有住家使用了相似名称" preferredStyle:1];
                        UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"好的" style:0 handler:nil];
                        [inputNameAlert addAction:action1];
                        [self presentViewController:inputNameAlert animated:YES completion:nil];
                        return ;
                    }
                    [model.serviceGroup updateName:name completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            block(YES);
                        }
                    }];
                }];
                [inputNameAlert addAction:action1];
                [inputNameAlert addAction:action2];
                [self presentViewController:inputNameAlert animated:YES completion:nil];
            }else if ([action.title isEqualToString:@"删除"]){
                [_currentHome removeServiceGroup:model.serviceGroup completionHandler:^(NSError * _Nullable error) {
                    if (!error) {
                        block(YES);
                    }
                }];
            }
        }];
        [homeList addAction:action1];
    }
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    [homeList addAction:action1];
    [self presentViewController:homeList animated:YES completion:^{}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:animated];
    }
}

- (void)presentsViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController) {
        [self presentViewController:viewController animated:animated completion:nil];
    }
}

- (NSArray*)getOperations
{
    return @[@"重命名",@"删除"];
}

- (NSArray*)getTriggers
{
    return @[@"时间触发器"];
}

- (void)setRefrefesh
{
    __unsafe_unretained UITableView *tableView = self.tableView;
    __weak typeof (self) weakSelf = self;
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.dataSource setCurrentChooseHome:_currentHome];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_header endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)callBack:(id)info withObject:(id)info1
{
    if (info && [info isKindOfClass:[SPSetTriggerController class]]) {
        [_dataSource setCurrentChooseHome:_currentHome];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
