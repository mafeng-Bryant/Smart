//
//  SPSettingDataSource.m
//  SmartPlug
//
//  Created by patpat on 2017/12/1.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPSettingDataSource.h"
#import "SPSettingNormalCell.h"
#import "SPTriggerNormalView.h"
#import "Help.h"
#import "MBProgressHUD.h"
#import "SPSynchTimeModel.h"
#import "SPDataManager.h"
#import "NSDate+Extensions.h"

@interface SPSettingDataSource()
{
    
    
    
}
@property (nonatomic,strong) SPSettingTableViewInfo* tableViewInfo;
@property (nonatomic,strong) HMAccessory* accessory;

@end

@implementation SPSettingDataSource

- (id)initWithTableView:(UITableView *)tableView
              accessory:(HMAccessory*)accessory
          tableViewInfo:(SPSettingTableViewInfo *)tableViewInfo
{
    self = [super initWithTableView:tableView];
    if (self) {
        //register cell
        [SPSettingNormalCell registerNibToTableView:tableView];
        tableView.separatorColor = [UIColor clearColor];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.estimatedRowHeight = 44;
        tableView.scrollEnabled = YES;
        self.tableViewInfo = tableViewInfo;
        self.accessory = accessory;
        [self refreshUI];
        tableView.tableHeaderView = [self tableViewForHeadView];
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
    SPSettingTableViewSectionObject *sectionObject = [self sectionObject:indexPath.section];
    SPSettingTableViewRowObject *rowObject = [self rowObject:indexPath];
    if (sectionObject.type == SPSettingTableViewSectionTypeInfo) {
            SPSettingNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPSettingNormalCell reuseIdentifier] forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLbl.text = rowObject.title;
           cell.descptionLbl.text = rowObject.value;
        return cell;

    }else if (sectionObject.type == SPSettingTableViewSectionTypeVersion){
        
        SPSettingNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPSettingNormalCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLbl.text = rowObject.title;
        cell.descptionLbl.text = rowObject.value;
        return cell;
        
    }else if (sectionObject.type == SPSettingTableViewSectionTypeSynchTime){
        
        SPSettingNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPSettingNormalCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLbl.text = rowObject.title;
        cell.descptionLbl.text = rowObject.value;
        return cell;
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
    return 45.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headView];
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
    SPSettingTableViewSectionObject *sectionObject = [self sectionObject:indexPath.section];
    SPSettingTableViewRowObject *rowObject = [self rowObject:indexPath];
    if (sectionObject.type == SPSettingTableViewSectionTypeInfo) {
        if (rowObject.type == SPSettingTableViewRowTypeRegnize) {
            [self.accessory identifyWithCompletionHandler:^(NSError * _Nullable error) {
                if (error) {
                    [self showTips:@"暂时无法识别设备，请稍后!"];
                }
            }];
        }
    }else if (sectionObject.type == SPSettingTableViewSectionTypeSynchTime){
        SPSynchTimeModel* model = [[SPDataManager sharedSPDataManager] getTimeModel];
        if (model) {
            model.dateString = [NSString stringWithFormat:@"%@",[[NSDate date] formatHMSYMD]];
            [[SPDataManager sharedSPDataManager] updtaTime:model];
            [self refreshUI];
        }
    }else if (sectionObject.type == SPSettingTableViewRowTypeUpdataVersion){
        
        
        
        
    }
}

#pragma mark Private

- (SPSettingTableViewSectionObject *)sectionObject:(NSInteger)section
{
    return  self.dataSource[section];
}

- (SPSettingTableViewRowObject *)rowObject:(NSIndexPath *)indexPath
{
    SPSettingTableViewSectionObject *sectionObject = self.dataSource[indexPath.section];
    return sectionObject.rows[indexPath.row];
}

- (void)refreshUI
{
    [self.tableViewInfo configureData:self.dataSource
                            accessory:self.accessory
                   containerViewWidth:self.tableView.frame.size.width];
    [self.tableView reloadData];
}

- (UIView*)tableViewForHeadView
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
}

- (UIView*)headView
{
    SPTriggerNormalView* view = [SPTriggerNormalView instanceHeadView];
    view.bgView.backgroundColor = [UIColor blackColor];
    ViewRadius(view.bgView, VMargin10);
    view.nameLbl.text = self.accessory.name;
    view.nameLbl.font = [UIFont fontWithName:@"Avenir Roman" size:16];
    view.nameLbl.textColor = [UIColor whiteColor];
    return view;
}

- (void)showTips:(NSString*)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}


@end
