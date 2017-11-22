//
//  SPSceneSetActionDataSource.m
//  SmartPlug
//
//  Created by patpat on 2017/11/10.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPSceneSetActionDataSource.h"
#import "SPSceneSetCell.h"
#import "Help.h"

@interface SPSceneSetActionDataSource()<HMAccessoryDelegate>
@property (nonatomic,strong) SPActionSetTableViewInfo* tableViewInfo;
@property (nonatomic,strong) HMAccessory* accessory;
@property (nonatomic,strong) UIView* headView;
@property (nonatomic,strong) HMService* primaryService;
@property (nonatomic,strong) HMCharacteristic* chaTx;//写特征
@property (nonatomic,strong) HMCharacteristic* chaRx;//读特征
@property (nonatomic,strong) HMHome* currentHome;
@property (nonatomic,strong) SPActionSetModel* model;

@end

@implementation SPSceneSetActionDataSource

- (id)initWithTableView:(UITableView *)tableView
                  model:(SPActionSetModel*)model
          tableViewInfo:(SPActionSetTableViewInfo *)tableViewInfo
{
    self = [super initWithTableView:tableView];
    if (self) {
        [SPSceneSetCell registerNibToTableView:tableView];
        tableView.separatorColor = [UIColor clearColor];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.estimatedRowHeight = 44;
        tableView.scrollEnabled = YES;
        self.tableViewInfo = tableViewInfo;
        self.model = model;
    }
    return self;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self sectionObject:section].rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPActionSetTableViewSectionObject *sectionObject = [self sectionObject:indexPath.section];
    SPActionSetTableViewRowObject *rowObject = [self rowObject:indexPath];
    if (sectionObject.type == SPActionSetSectionTypeHeader) {
        if (rowObject.type == SPActionSetRowTypeOpen) {
             SPSceneSetCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPSceneSetCell reuseIdentifier] forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.stateLbl.text = @"电源状态: 开";
            if (!rowObject.hasValue) {
                cell.selectImageView.hidden = YES;
            }else {
                id chooseValue = self.tableViewInfo.currentChooseAction.targetValue;
                id rowValue = rowObject.action.targetValue;
                if ([chooseValue integerValue] == [rowValue integerValue]) {
                    cell.selectImageView.hidden = NO;
                }else {
                    cell.selectImageView.hidden = YES;
                }
            }
            return cell;
            
        }else if (rowObject.type == SPActionSetRowTypeClose) {
   
            SPSceneSetCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPSceneSetCell reuseIdentifier] forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.stateLbl.text = @"电源状态: 关";
            if (!rowObject.hasValue) {
                cell.selectImageView.hidden = YES;
            }else {
                id chooseValue = self.tableViewInfo.currentChooseAction.targetValue;
                id rowValue = rowObject.action.targetValue;
                if ([chooseValue integerValue] == [rowValue integerValue]) {
                    cell.selectImageView.hidden = NO;
                }else {
                    cell.selectImageView.hidden = YES;
                }
            }
            return cell;
        }
    }
    return nil;
}

#pragma mark  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self rowObject:indexPath].height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.primaryService.characteristics.count>0) {
        return 60.0f;
    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.primaryService.characteristics.count>0) {
        SPActionSetTableViewSectionObject *sectionObject = self.dataSource[section];
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
        view.backgroundColor = [UIColor clearColor];
        UIView* bgView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, tableView.frame.size.width-40, 50)];
        bgView.backgroundColor = [UIColor blackColor];
        ViewRadius(bgView, 10);
        [view addSubview:bgView];
        UILabel* tipsLbl = [[UILabel alloc]initWithFrame:CGRectZero];
        tipsLbl.textColor = [UIColor whiteColor];
        tipsLbl.text = sectionObject.title;
        [bgView addSubview:tipsLbl];
        tipsLbl.font = [UIFont systemFontOfSize:14];
        [tipsLbl sizeToFit];
        tipsLbl.frame = CGRectMake(10, (50 - tipsLbl.frame.size.height)/2.0, tipsLbl.frame.size.width, tipsLbl.frame.size.height);
        return view;
    }
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.01f)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.01f)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SPActionSetTableViewRowObject *rowObject = [self rowObject:indexPath];
    __weak typeof (self) weakSelf = self;
   if (!self.tableViewInfo.currentChooseAction) {
        [self.model.actionSet addAction:rowObject.action completionHandler:^(NSError * _Nullable error) {
            if (!error) {
                weakSelf.tableViewInfo.currentChooseAction = rowObject.action;
                [weakSelf refreshUI];
                NSLog(@"添加动作集成功");
            }
        }];
    }else {
        //存在的话就判断是不是点击同一个，是就取消，否则移除,添加新的
        id value1 = self.tableViewInfo.currentChooseAction.targetValue;
        id value2 = rowObject.action.targetValue;
        if ([value1 integerValue] == [value2 integerValue]) {
            if ([rowObject.action.targetValue integerValue] == 1) {
                [self.model.actionSet removeAction:self.tableViewInfo.currentChooseAction completionHandler:^(NSError * _Nullable error) {
                    if (!error) {
                        self.tableViewInfo.currentChooseAction = nil;
                        [weakSelf refreshUI];
                        NSLog(@"移除成功");
                    }
                }];
            }else {
                [self.model.actionSet removeAction:self.tableViewInfo.currentChooseAction completionHandler:^(NSError * _Nullable error) {
                    if (!error) {
                        self.tableViewInfo.currentChooseAction = nil;
                        [weakSelf refreshUI];
                    }
                }];
            }
        }else {

            [self.model.actionSet removeAction:self.tableViewInfo.currentChooseAction completionHandler:^(NSError * _Nullable error) {
                if (!error) {
                    NSLog(@"移除成功");
                    [self.model.actionSet addAction:rowObject.action completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            weakSelf.tableViewInfo.currentChooseAction = rowObject.action;
                            [weakSelf refreshUI];
                            NSLog(@"添加动作集成功");
                        }
                    }];
                }
            }];
        }
    }
}

#pragma mark Private

- (SPActionSetTableViewSectionObject *)sectionObject:(NSInteger)section
{
    return  self.dataSource[section];
}

- (SPActionSetTableViewRowObject *)rowObject:(NSIndexPath *)indexPath
{
    SPActionSetTableViewSectionObject *sectionObject = self.dataSource[indexPath.section];
    return sectionObject.rows[indexPath.row];
}

- (void)refreshUI
{
    [self getPrimaryService];
    [self.tableViewInfo configureData:self.dataSource
                                 home:self.currentHome
                                model:self.model
                              service:self.primaryService
                   containerViewWidth:self.tableView.frame.size.width];
    [self.tableView reloadData];
}

- (void)pushViewController:(UIViewController*)vc animatined:(BOOL)animatined
{
    if (self.dataSourceAccessory && [self.dataSourceAccessory respondsToSelector:@selector(pushViewController:animated:)]) {
        [self.dataSourceAccessory pushViewController:vc animated:animatined];
    }
}

- (void)setCurrentChooseHome:(HMHome*)home
{
    if (home) {
        self.currentHome = home;
        [self refreshUI];
    }
}

#pragma mark set and get method

- (void)getPrimaryService
{
    for (HMAccessory* accessory in self.currentHome.accessories) {
        self.accessory = accessory;
    }
    for (HMService* service  in self.accessory.services) {
        if ([service isPrimaryService]) {
            self.primaryService = service;
        }
    }
}

- (void)accessory:(HMAccessory *)accessory service:(HMService *)service didUpdateValueForCharacteristic:(HMCharacteristic *)characteristic
{
    //更新了属性
    NSLog(@"更新了属性");
}

- (void)updateCharacteristic:(HMAccessory*)accessory cha:(HMCharacteristic*)cha
{
    NSLog(@"特征值已经改变 = %@",cha.value);
}

- (void)accessoryDidUpdateReachability:(HMAccessory *)accessory;
{
    NSLog(@"accessoryDidUpdateReachability");
}
- (void)accessory:(HMAccessory *)accessory didUpdateFirmwareVersion:(NSString *)firmwareVersion
{
    NSLog(@"didUpdateFirmwareVersion");
}


@end
