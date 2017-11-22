//
//  SPConfigureDataSource.m
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPConfigureDataSource.h"
#import "SPConfigureTableViewInfo.h"
#import "SPConfigureUserCell.h"
#import "SPConfigureZonesCell.h"
#import "SPConfigureServiceCell.h"
#import "SPConfigureTriggersCell.h"
#import "SPConfigureHeadView.h"
#import "Help.h"
#import "SPConfigureChooseRoomController.h"
#import "SPBaseNavigationController.h"
#import "SPConfigureZoneModel.h"
#import "SPConfigureChooseServiceController.h"
#import "SPSetTriggerController.h"
#import <HomeKit/HomeKit.h>

@interface SPConfigureDataSource()<UniversalDelegate>

@property (nonatomic,strong) SPConfigureTableViewInfo* tableViewInfo;
@property (nonatomic,strong) UIView* headView;
@property (nonatomic,strong) HMHome* currentHome;

@end

@implementation SPConfigureDataSource

-(id)initWithTableView:(UITableView *)tableView
           currentHome:(HMHome*)currentHome
         tableViewInfo:(SPConfigureTableViewInfo*)tableViewInfo
{
    self = [super initWithTableView:tableView];
    if (self) {
        [SPConfigureUserCell registerNibToTableView:tableView];
        [SPConfigureZonesCell registerNibToTableView:tableView];
        [SPConfigureServiceCell registerNibToTableView:tableView];
        [SPConfigureTriggersCell registerNibToTableView:tableView];
        tableView.separatorColor = [UIColor clearColor];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.estimatedRowHeight = 44;
        tableView.scrollEnabled = YES;
        self.tableViewInfo = tableViewInfo;
        self.currentHome = currentHome;
        self.tableView.tableHeaderView = [self headView];
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
    SPConfigureTableViewSectionObject *sectionObject = [self sectionObject:indexPath.section];
    SPConfigureTableViewRowObject *rowObject = [self rowObject:indexPath];
    if (sectionObject.type == SPConfigureSectionTypeUser) {
        if (rowObject.type == SPConfigureRowTypeUser) {
            SPConfigureUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureUserCell reuseIdentifier] forIndexPath:indexPath];
            return cell;
        }else if (rowObject.type == SPConfigureRowTypeDefault){
            SPConfigureUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureUserCell reuseIdentifier] forIndexPath:indexPath];
            return cell;
        }
    }else if (sectionObject.type == SPConfigureSectionTypeZones){
        if (rowObject.type == SPConfigureRowTypeZones) {
            SPConfigureZonesCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureZonesCell reuseIdentifier] forIndexPath:indexPath];
            cell.zoneNameLbl.text = rowObject.model.zone.name;
            cell.roomLbl.text = @"房间:";
            cell.arrowImageView.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configureData:rowObject.model];
            cell.model = rowObject.model;
            UILongPressGestureRecognizer* tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(zoneAction:)];
            [cell addGestureRecognizer:tap];
            return cell;
        }else if (rowObject.type == SPConfigureRowTypeDefault){
            SPConfigureZonesCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureZonesCell reuseIdentifier] forIndexPath:indexPath];
            cell.zoneNameLbl.text = @"";
            cell.roomLbl.text = @"";
            cell.arrowImageView.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }else if (sectionObject.type == SPConfigureSectionTypeServiceGroup)
    {
        if (rowObject.type == SPConfigureRowTypeService)
        {
            SPConfigureServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureServiceCell reuseIdentifier] forIndexPath:indexPath];
            [cell configureData:rowObject.model];
            cell.model = rowObject.model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILongPressGestureRecognizer* tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(serviceAction:)];
            [cell addGestureRecognizer:tap];
            return cell;
        }else if (rowObject.type == SPConfigureRowTypeDefault){
            SPConfigureUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureUserCell reuseIdentifier] forIndexPath:indexPath];
            return cell;
        }
    }else if (sectionObject.type == SPConfigureSectionTypeTriggers){
        if (rowObject.type == SPConfigureRowTypeTriggers) {
            
            SPConfigureTriggersCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureTriggersCell reuseIdentifier] forIndexPath:indexPath];
            cell.nameLbl.text = rowObject.model.trigger.name;
            cell.timeLbl.text = [self formatMDHMS:rowObject.model.trigger.fireDate];
            cell.model = rowObject.model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILongPressGestureRecognizer* tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(triggerAction:)];
            [cell addGestureRecognizer:tap];
            return cell;
            
        }else if (rowObject.type == SPConfigureRowTypeDefault){
            
            SPConfigureZonesCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureZonesCell reuseIdentifier] forIndexPath:indexPath];
            cell.arrowImageView.hidden = YES;
            cell.zoneNameLbl.text = @"";
            cell.roomLbl.text = @"";
            return cell;
        }
    }
    return nil;
}


- (NSString *)formatDate:(NSDate *)confromTime dateStyle:(NSString *)dateStyle
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateStyle];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTime];
    return confromTimespStr;
}

- (NSString*)formatMDHMS:(NSDate*)date
{
    return [self formatDate:date dateStyle:@"MM-dd HH:mm:ss"];
}

#pragma mark  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self rowObject:indexPath].height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headView:section];
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
    SPConfigureTableViewSectionObject *sectionObject = self.dataSource[indexPath.section];
    SPConfigureTableViewRowObject *rowObject = [self rowObject:indexPath];
    if (sectionObject.type == SPConfigureSectionTypeZones) {
        SPConfigureChooseRoomController* chooseVC = [[SPConfigureChooseRoomController alloc]initWithNibName:@"SPConfigureChooseRoomController" bundle:nil model:rowObject.model];
        SPBaseNavigationController* na = [[SPBaseNavigationController alloc]initWithRootViewController:chooseVC];
        if (self.dataSourceAccessory && [self.dataSourceAccessory respondsToSelector:@selector(presentsViewController:animated:)]) {
            [self.dataSourceAccessory presentsViewController:na animated:YES];
        }
    }else if (sectionObject.type == SPConfigureSectionTypeServiceGroup){
        SPConfigureChooseServiceController* serviceVC = [[SPConfigureChooseServiceController alloc]initWithNibName:@"SPConfigureChooseServiceController" bundle:nil model:rowObject.model];
         SPBaseNavigationController* na = [[SPBaseNavigationController alloc]initWithRootViewController:serviceVC];
        if (self.dataSourceAccessory && [self.dataSourceAccessory respondsToSelector:@selector(presentsViewController:animated:)]) {
            [self.dataSourceAccessory presentsViewController:na animated:YES];
        }
    }else if (sectionObject.type == SPConfigureSectionTypeTriggers){
       
        SPSetTriggerController* vc = [[SPSetTriggerController alloc]initWithNibName:@"SPSetTriggerController"
                                                                             bundle:nil
                                                                              model:rowObject.model
                                                                               type:SPTriggerTypeTime
                                      operationType:SPTriggerOperationTypeEdit];
        vc.universalDelegate = self;
        SPBaseNavigationController* na = [[SPBaseNavigationController alloc]initWithRootViewController:vc];
        if (self.dataSourceAccessory && [self.dataSourceAccessory respondsToSelector:@selector(presentsViewController:animated:)]) {
            [self.dataSourceAccessory presentsViewController:na animated:YES];
        }
    }
}

- (void)zoneAction:(UILongPressGestureRecognizer*)tap
{
    SPConfigureZonesCell* cell = (SPConfigureZonesCell*)tap.view;
    if (self.dataSourceAccessory && [self.dataSourceAccessory respondsToSelector:@selector(renameZoneAndDelete:callBlock:)]) {
        [self.dataSourceAccessory renameZoneAndDelete:cell.model callBlock:^(BOOL result) {
            if (result) {
                [self refreshUI];
            }
        }];
    }
}

- (void)triggerAction:(UILongPressGestureRecognizer*)tap
{
    SPConfigureTriggersCell* cell = (SPConfigureTriggersCell*)tap.view;
    if (self.dataSourceAccessory && [self.dataSourceAccessory respondsToSelector:@selector(renameTriggerAndDelete:callBlock:)]) {
        [self.dataSourceAccessory renameTriggerAndDelete:cell.model callBlock:^(BOOL result) {
            if (result) {
                [self refreshUI];
            }
        }];
    }
}

- (void)serviceAction:(UILongPressGestureRecognizer*)tap
{
    SPConfigureServiceCell* cell = (SPConfigureServiceCell*)tap.view;
    if (self.dataSourceAccessory && [self.dataSourceAccessory respondsToSelector:@selector(renameServiceAndDelete:callBlock:)]) {
        [self.dataSourceAccessory renameServiceAndDelete:cell.model callBlock:^(BOOL result) {
            if (result) {
                [self refreshUI];
            }
        }];
    }
}

#pragma mark Private

- (SPConfigureTableViewSectionObject *)sectionObject:(NSInteger)section
{
    return  self.dataSource[section];
}

- (SPConfigureTableViewRowObject *)rowObject:(NSIndexPath *)indexPath
{
    SPConfigureTableViewSectionObject *sectionObject = self.dataSource[indexPath.section];
    return sectionObject.rows[indexPath.row];
}

- (void)refreshUI
{
    [self.tableViewInfo configureData:self.dataSource
                   home:self.currentHome
                   containerViewWidth:self.tableView.frame.size.width];
    [self.tableView reloadData];
}

- (UIView*)headView:(NSInteger)section
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    view.backgroundColor = [UIColor clearColor];
    SPConfigureHeadView* headView = [SPConfigureHeadView instanceHeadView];
    if (section == 0) {
        headView.sectionLbl.text = @"用户";
    }else if (section ==1){
        headView.sectionLbl.text = @"区域";
    }else if (section ==2){
        headView.sectionLbl.text = @"服务组";
    }else if (section ==3){
        headView.sectionLbl.text = @"触发器";
    }
    headView.section = section;
    headView.sectionLbl.textColor = [UIColor whiteColor];
    headView.frame = CGRectMake(20, 0, self.tableView.frame.size.width-40, 50);
    headView.backgroundColor = [UIColor blackColor];
    [view addSubview:headView];
    ViewRadius(headView, 5);
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addAction:)];
    [headView addGestureRecognizer:tap];
    return view;
}

- (UIView*)headView
{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
        _headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}

- (void)setCurrentChooseHome:(HMHome*)home
{
    if (home) {
        self.currentHome = home;
    }
    [self refreshUI];
}

- (void)addAction:(UITapGestureRecognizer*)tap
{
    SPConfigureHeadView* headView = (SPConfigureHeadView*)tap.view;
    SPConfigureTableViewSectionObject* sectionObject = [self sectionObject:headView.section];
    if (sectionObject.type == SPConfigureSectionTypeUser) {
        if ([self.dataSourceAccessory respondsToSelector:@selector(hiddenTitleView)]) {
            [self.dataSourceAccessory hiddenTitleView];
        }
        [self.currentHome manageUsersWithCompletionHandler:^(NSError * _Nullable error) {
              if (!error) {
                if ([self.dataSourceAccessory respondsToSelector:@selector(showTitleView)]) {
                    [self.dataSourceAccessory showTitleView];
                }
                NSLog(@"等待对方回复");
            }
        }];
    }else if (sectionObject.type == SPConfigureSectionTypeZones){
        if (self.dataSourceAccessory && [self.dataSourceAccessory respondsToSelector:@selector(addZonesCallBlock:)]) {
            [self.dataSourceAccessory addZonesCallBlock:^(BOOL result) {
                if (result) { //添加区域成功
                    [self refreshUI];
                }
            }];
        }
    }else if (sectionObject.type == SPConfigureSectionTypeServiceGroup){
        if (self.dataSourceAccessory && [self.dataSourceAccessory respondsToSelector:@selector(addServiceGroup:)]) {
            [self.dataSourceAccessory addServiceGroup:^(BOOL result) {
                if (result) {
                    [self refreshUI];
                }
            }];
        }
    }else if (sectionObject.type == SPConfigureSectionTypeTriggers){
        if (self.dataSourceAccessory && [self.dataSourceAccessory respondsToSelector:@selector(addTrigger:)]) {
            [self.dataSourceAccessory addTrigger:^(BOOL result) {
                if (result) {
                    [self refreshUI];
                }
            }];
        }
    }
}

#pragma mark UniversalDelegate

- (void)callBack:(id)info withObject:(id)info1
{
    if (info && [info isKindOfClass:[SPSetTriggerController class]]) {
        [self refreshUI];
    }
}

- (void)pushViewController:(UIViewController*)vc animatined:(BOOL)animatined
{

    

}

@end
