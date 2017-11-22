//
//  SPTriggerDataSource.m
//  SmartPlug
//
//  Created by patpat on 2017/11/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTriggerDataSource.h"
#import "SPTriggerNormalCell.h"
#import "SPConfigureUserCell.h"
#import "SPTriggerPickDateCell.h"
#import "SPTriggerNameView.h"
#import "SPTriggerSettingView.h"
#import "SPTriggerNormalView.h"
#import "Help.h"
#import "SPActionSetModel.h"
#import "SPDatePicker.h"
#import "MBProgressHUD.h"

@interface SPTriggerDataSource()<UITextFieldDelegate>

@property (nonatomic,strong) SPTriggerTableViewInfo* tableViewInfo;
@property (nonatomic,strong) UIView* headView;
@property (nonatomic,strong) SPDatePicker* picker;
@property (nonatomic,strong) UISwitch* mySwitch;

@end

@implementation SPTriggerDataSource

-(id)initWithTableView:(UITableView *)tableView
         tableViewInfo:(SPTriggerTableViewInfo*)tableViewInfo
{
    self = [super initWithTableView:tableView];
    if (self) {
        [SPTriggerNormalCell registerNibToTableView:tableView];
        [SPTriggerPickDateCell registerNibToTableView:tableView];
        [SPConfigureUserCell registerNibToTableView:tableView];
        tableView.separatorColor = [UIColor clearColor];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.estimatedRowHeight = 44;
        tableView.scrollEnabled = YES;
        self.tableViewInfo = tableViewInfo;
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
    SPTriggerTableViewSectionObject *sectionObject = [self sectionObject:indexPath.section];
    SPTriggerTableViewRowObject *rowObject = [self rowObject:indexPath];
    if (sectionObject.type == SPHelpSectionTypeTriggerName) {
        if (rowObject.type == SPTriggerRowTypeDefalut) {
            SPConfigureUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureUserCell reuseIdentifier] forIndexPath:indexPath];
            return cell;
        }
    }else if (sectionObject.type == SPTriggerSectionTypeEnableSettings){
        if (rowObject.type == SPTriggerRowTypeDefalut) {
            
            SPConfigureUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureUserCell reuseIdentifier] forIndexPath:indexPath];
            return cell;
        }
        
    }else if (sectionObject.type == SPHelpSectionTypeScenes)
    {
        if (rowObject.type == SPTriggerRowTypeDefalut)
        {
            SPConfigureUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureUserCell reuseIdentifier] forIndexPath:indexPath];
            return cell;
        }else if (rowObject.type == SPTriggerRowTypeNormal){
            SPActionSetModel* model = rowObject.model;
            SPTriggerNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPTriggerNormalCell reuseIdentifier] forIndexPath:indexPath];
            cell.nameLbl.text = model.actionSet.name;
            if ([self.tableViewInfo.chooseSceneDatas containsObject:model]) {
                cell.chooseImageView.hidden = NO;
            }else {
                cell.chooseImageView.hidden = YES;
            }
            return cell;
        }
    }else if (sectionObject.type == SPHelpSectionTypeTimeAndDate){
        if (rowObject.type == SPTriggerRowTypeChooseTime) {
            SPTriggerPickDateCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPTriggerPickDateCell
                                                                                        reuseIdentifier] forIndexPath:indexPath];
            [cell addSubview:self.picker];
            return cell;
        }
    }else if (sectionObject.type == SPHelpSectionTypeDate){
        
        SPTriggerNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPTriggerNormalCell reuseIdentifier] forIndexPath:indexPath];
        cell.nameLbl.text = rowObject.title;
        if (self.tableViewInfo.chooseRowObject == rowObject) {
            cell.chooseImageView.hidden = NO;
        }else {
            cell.chooseImageView.hidden = YES;
        }
        return cell;
 
    }else if (sectionObject.type == SPHelpSectionTypeSpecial){
        if (rowObject.type == SPTriggerRowTypeDefalut)
        {
            SPConfigureUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureUserCell reuseIdentifier] forIndexPath:indexPath];
            return cell;
        }
    }else if (sectionObject.type == SPHelpSectionTypeCondition){
        if (rowObject.type == SPTriggerRowTypeDefalut)
        {
            SPConfigureUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureUserCell reuseIdentifier] forIndexPath:indexPath];
            return cell;
        }
    }
    return nil;
}


#pragma mark  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPTriggerTableViewRowObject *rowObject = [self rowObject:indexPath];
    if (rowObject.type == SPTriggerRowTypeChooseTime) {
        return 226;
    }
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
    SPTriggerTableViewSectionObject *sectionObject = self.dataSource[indexPath.section];
    SPTriggerTableViewRowObject *rowObject = [self rowObject:indexPath];
    if (sectionObject.type == SPHelpSectionTypeScenes) {
        SPActionSetModel* model = rowObject.model;
        if (![self.tableViewInfo.chooseSceneDatas containsObject:model]) {
            [self.tableViewInfo.chooseSceneDatas removeAllObjects];
            [self.tableViewInfo.chooseSceneDatas addObject:model];
        }else {
            [self.tableViewInfo.chooseSceneDatas removeObject:model];
            self.tableViewInfo.isSure = NO;
            self.mySwitch.on = NO;
        }
        [self.tableView reloadData];
    }else if (sectionObject.type == SPHelpSectionTypeDate){
        if (!self.tableViewInfo.chooseRowObject) {
            self.tableViewInfo.chooseRowObject = rowObject;
            self.tableViewInfo.chooseTimeType = rowObject.timeType;
        }else {
            if (self.tableViewInfo.chooseRowObject !=rowObject) {
                self.tableViewInfo.chooseRowObject = rowObject;
                self.tableViewInfo.chooseTimeType = rowObject.timeType;
            }else {
                self.tableViewInfo.chooseRowObject = nil;
                self.tableViewInfo.chooseTimeType = SPTriggerTimeTypeNone;
            }
        }
        [self.tableView reloadData];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView endEditing:YES];
}

#pragma mark Private

- (SPTriggerTableViewSectionObject*)sectionObject:(NSInteger)section
{
    return  self.dataSource[section];
}

- (SPTriggerTableViewRowObject*)rowObject:(NSIndexPath *)indexPath
{
    SPTriggerTableViewSectionObject *sectionObject = self.dataSource[indexPath.section];
    return sectionObject.rows[indexPath.row];
}

- (void)refreshUI
{
    [self.tableViewInfo configureData:self.dataSource containerViewWidth:self.tableView.frame.size.width];
    [self.tableView reloadData];
}

- (UIView*)headView:(NSInteger)section
{
    SPTriggerTableViewSectionObject *sectionObject = self.dataSource[section];
    if (sectionObject.type == SPHelpSectionTypeTriggerName) {
        SPTriggerNameView* view = [SPTriggerNameView instanceHeadView];
        view.textField.delegate = self;
        view.bgView.backgroundColor = [UIColor blackColor];
        ViewRadius(view.bgView, VMargin10);
        view.textField.placeholder = @"触发器的名称";
        view.textField.textColor = [UIColor whiteColor];
        [view.textField setValue:RGB(155,165,167,1.0) forKeyPath:@"_placeholderLabel.textColor"];
        [view.textField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        view.textField.text = self.tableViewInfo.triggerName;
        return view;
    }else if (sectionObject.type == SPTriggerSectionTypeEnableSettings){
        SPTriggerSettingView* view = [SPTriggerSettingView instanceHeadView];
        view.bgView.backgroundColor = [UIColor blackColor];
        ViewRadius(view.bgView, VMargin10);
        view.nameLbl.text = @"启用设定";
        view.nameLbl.textColor = [UIColor whiteColor];
        view.mySwitch.on = self.tableViewInfo.isSure;
        self.mySwitch = view.mySwitch;
        [view.mySwitch addTarget:self action:@selector(chooseUseAction:) forControlEvents:UIControlEventValueChanged];
        return view;
    }else if (sectionObject.type == SPHelpSectionTypeScenes){
        SPTriggerNormalView* view = [SPTriggerNormalView instanceHeadView];
        view.bgView.backgroundColor = [UIColor blackColor];
        ViewRadius(view.bgView, VMargin10);
        view.nameLbl.text = @"场景";
        view.nameLbl.textColor = [UIColor whiteColor];
        return view;
    }else if (sectionObject.type == SPHelpSectionTypeTimeAndDate){
        SPTriggerNormalView* view = [SPTriggerNormalView instanceHeadView];
        view.bgView.backgroundColor = [UIColor blackColor];
        ViewRadius(view.bgView, VMargin10);
        view.nameLbl.text = @"日期和时间";
        view.nameLbl.textColor = [UIColor whiteColor];
        return view;
    }else if (sectionObject.type == SPHelpSectionTypeDate){
        SPTriggerNormalView* view = [SPTriggerNormalView instanceHeadView];
        view.bgView.backgroundColor = [UIColor blackColor];
        ViewRadius(view.bgView, VMargin10);
        view.nameLbl.textColor = [UIColor whiteColor];
        view.nameLbl.text = @"重复";
        return view;
    }else if (sectionObject.type == SPHelpSectionTypeSpecial){
        
        
        
    }else if (sectionObject.type == SPHelpSectionTypeCondition){
        
    
    }
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 0.01f)];
}

- (UIView*)headView
{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
        _headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}

-(SPDatePicker *)picker
{
    if (!_picker) {
        _picker = [[SPDatePicker alloc]initWithframe:CGRectMake(0, 0, self.tableView.frame.size.width, 216) PickerStyle:0 didSelected:^(NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *weekDay) {
            NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
            formatter.dateFormat=@"yyyyMMddHHmm";
            self.tableViewInfo.chooseDate = [formatter dateFromString:[NSString stringWithFormat:@"%@%@%@%@%@",year,month,day,hour,minute]];
            if ([self.tableViewInfo.chooseDate timeIntervalSinceNow] < [[NSDate date] timeIntervalSinceNow]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"日期选择错误，触发器的触发时间必须大于当前日期";
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:2];
            }
        }];
        _picker.minLimitDate=[NSDate dateWithTimeIntervalSinceNow:0];
    }
    return _picker;
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.tableViewInfo.triggerName = textField.text;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.tableViewInfo.triggerName = textField.text;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)chooseUseAction:(UISwitch*)mySwitch
{
    if (self.tableViewInfo.chooseSceneDatas.count<=0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请先设置场景再启动触发器!";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
        mySwitch.on = NO;
        return;
    }
    self.tableViewInfo.isSure = mySwitch.on;
}

- (void)pushViewController:(UIViewController*)vc animatined:(BOOL)animatined
{
    
    
}

@end
