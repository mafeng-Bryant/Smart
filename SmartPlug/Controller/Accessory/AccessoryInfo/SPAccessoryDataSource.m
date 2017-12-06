//
//  SPAccessoryDataSource.m
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPAccessoryDataSource.h"
#import "Help.h"
#import "SPAccessoryRecognizeCell.h"
#import "SPAccessoryStatusCell.h"
#import "SPAccessoryCommonCell.h"
#import "SPAccessoryTypeCell.h"
#import "PPSwitch.h"
#import "UIView+Extensions.h"
#import "MBProgressHUD.h"

@interface SPAccessoryDataSource()<HMAccessoryDelegate>
@property (nonatomic,strong) SPAccessoryTableViewInfo* tableViewInfo;
@property (nonatomic,strong) HMAccessory* accessory;
@property (nonatomic,strong) UIView* headView;
@property (nonatomic,strong) HMService* primaryService;
@property (nonatomic,strong) HMCharacteristic* chaTx;//写特征
@property (nonatomic,strong) HMCharacteristic* chaRx;//读特征

@end

@implementation SPAccessoryDataSource

- (id)initWithTableView:(UITableView *)tableView
              accessory:(HMAccessory*)accessory
          tableViewInfo:(SPAccessoryTableViewInfo *)tableViewInfo
{
    self = [super initWithTableView:tableView];
    if (self) {
        //register cell
        [SPAccessoryRecognizeCell registerNibToTableView:tableView];
        [SPAccessoryStatusCell registerNibToTableView:tableView];
        [SPAccessoryCommonCell registerNibToTableView:tableView];
        [SPAccessoryTypeCell registerNibToTableView:tableView];
        tableView.separatorColor = [UIColor clearColor];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.estimatedRowHeight = 44;
        tableView.scrollEnabled = YES;
        self.tableViewInfo = tableViewInfo;
        self.accessory = accessory;
        [self refreshUI];
        tableView.tableHeaderView = [self headView];
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
    SPAccessoryTableViewSectionObject *sectionObject = [self sectionObject:indexPath.section];
    SPAccessoryTableViewRowObject *rowObject = [self rowObject:indexPath];
    if (sectionObject.type == SPAccessoryTableViewSectionTypeStatus) {
        if (rowObject.type == SPAccessoryTableViewRowTypeStatus) {
           SPAccessoryStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPAccessoryStatusCell reuseIdentifier] forIndexPath:indexPath];
            cell.statasLbl.text = @"电源状态";
            [cell.mySwitch addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventValueChanged];
            cell.mySwitch.accessory = self.accessory;
            [cell configureData:self.accessory type:SPAcceessoryStatesTypePower];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (rowObject.type == SPAccessoryTableViewRowTypePower) {
            SPAccessoryStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPAccessoryStatusCell reuseIdentifier] forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.statasLbl.text = @"电器已经接";
            cell.mySwitch.enabled = NO;
            [cell configureData:self.accessory type:SPAcceessoryStatesTypeAppliance];
            return cell;
        }else if (rowObject.type == SPAccessoryTableViewRowTypeCommon) {
            
            SPAccessoryCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPAccessoryCommonCell reuseIdentifier] forIndexPath:indexPath];
            cell.accessoryNameLbl.text = self.primaryService.name;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
      }else if (sectionObject.type == SPAccessoryTableViewSectionTypeName){
         
          if (rowObject.type == SPAccessoryTableViewRowTypeCommon) {
              
              SPAccessoryCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPAccessoryCommonCell reuseIdentifier] forIndexPath:indexPath];
              cell.accessoryNameLbl.text = self.accessory.name;
              cell.selectionStyle = UITableViewCellSelectionStyleNone;
              return cell;
          }
          
      }else if (sectionObject.type == SPAccessoryTableViewSectionTypeService){
        
          if (rowObject.type == SPAccessoryTableViewRowTypeAccessory) {
            
              SPAccessoryTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPAccessoryTypeCell reuseIdentifier] forIndexPath:indexPath];
              cell.selectionStyle = UITableViewCellSelectionStyleNone;
              return cell;
            
          }else if (rowObject.type == SPAccessoryTableViewRowTypeRecognizeAccessory){
            
              SPAccessoryRecognizeCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPAccessoryRecognizeCell reuseIdentifier] forIndexPath:indexPath];
              cell.selectionStyle = UITableViewCellSelectionStyleNone;
              [cell.regiseBtn addTarget:self action:@selector(findAction:) forControlEvents:UIControlEventTouchUpInside];
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
    return 45.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SPAccessoryTableViewSectionObject *sectionObject = [self sectionObject:section];
    return  [self sectionHeaderView:sectionObject.type];
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
}

#pragma mark Private

- (SPAccessoryTableViewSectionObject *)sectionObject:(NSInteger)section
{
    return  self.dataSource[section];
}

- (SPAccessoryTableViewRowObject *)rowObject:(NSIndexPath *)indexPath
{
    SPAccessoryTableViewSectionObject *sectionObject = self.dataSource[indexPath.section];
    return sectionObject.rows[indexPath.row];
}

- (void)refreshUI
{    
    [self getPrimaryService];
    [self.tableViewInfo configureData:self.dataSource
                            accessory:self.accessory
                   containerViewWidth:self.tableView.frame.size.width];
    [self.tableView reloadData];
}

- (void)pushViewController:(UIViewController*)vc animatined:(BOOL)animatined
{
    if (self.dataSourceAccessory && [self.dataSourceAccessory respondsToSelector:@selector(pushViewController:animated:)]) {
        [self.dataSourceAccessory pushViewController:vc animated:animatined];
    }
}

#pragma mark set and get method

- (UIView*)headView
{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        _headView.backgroundColor = [UIColor clearColor];
        UILabel* statusLbl = [[UILabel alloc]initWithFrame:CGRectZero];
        statusLbl.text = [NSString stringWithFormat:@"设备:%@",self.accessory.reachable?@"可用":@"不可用"];
        statusLbl.textAlignment = NSTextAlignmentCenter;
        [statusLbl sizeToFit];
        statusLbl.frame = CGRectMake((_headView.frame.size.width - statusLbl.frame.size.width)/2.0, 16,statusLbl.frame.size.width, statusLbl.frame.size.height);
        statusLbl.textColor = [UIColor blackColor];
        statusLbl.font = [UIFont systemFontOfSize:14];
        [_headView addSubview:statusLbl];
    }
    return _headView;
}

- (UIView*)sectionHeaderView:(SPAccessoryTableViewSectionType)type
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 45)];
    view.backgroundColor = [UIColor clearColor];
    UIView* buttonView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, self.tableView.frame.size.width-40, 45)];
    buttonView.backgroundColor = [UIColor blackColor];
    buttonView.userInteractionEnabled = NO;
    [view addSubview:buttonView];
    if (type == SPAccessoryTableViewSectionTypeStatus) {
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeServiceName:)];
        [view addGestureRecognizer:tap];
    }
    UILabel* nameLbl = [[UILabel alloc]initWithFrame:CGRectZero];
    nameLbl.textColor = [UIColor whiteColor];
    nameLbl.font = [UIFont fontWithName:@"Avenir-Roman" size:16];
    [buttonView addSubview:nameLbl];
    ViewRadius(buttonView, 10);
    if (type == SPAccessoryTableViewSectionTypeStatus) {
        nameLbl.text = self.primaryService.name;
    }else if (type == SPAccessoryTableViewSectionTypeName){
        nameLbl.text = self.accessory.name;
    }else if (type == SPAccessoryTableViewSectionTypeService){
        nameLbl.text = @"关联的服务类型";
    }
    [nameLbl sizeToFit];
    nameLbl.frame = CGRectMake(20, (45- nameLbl.frame.size.height)/2.0, nameLbl.frame.size.width, nameLbl.frame.size.height);
    return view;
}

- (void)getPrimaryService
{
    for (HMService* service  in self.accessory.services) {
        if (@available(iOS 10.0, *)) {
            if ([service isPrimaryService]) {
                self.primaryService = service;
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

- (void)changeServiceName:(UITapGestureRecognizer*)tap
{
    if (self.dataSourceAccessory && [self.dataSourceAccessory respondsToSelector:@selector(changeServiceName: callBlock:)]) {
        [self.dataSourceAccessory changeServiceName:self.primaryService callBlock:^(BOOL result) {
            if (result) {
                [self refreshUI];
            }
        }];
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

- (void)changeState:(PPSwitch*)mySwitch
{
    SPAccessoryStatusCell* cell = (SPAccessoryStatusCell*)[mySwitch parentTableViewCell];
    HMAccessory* accessory = mySwitch.accessory;
    NSArray* serviceArray = accessory.services;
    accessory.delegate = self;
    for (HMService* service in serviceArray) {
        NSArray* arr = service.characteristics;
        for (HMCharacteristic* cha in arr) {
            if ([cha.characteristicType isEqualToString:kAccessoryUUID]) {
                NSArray* properites = cha.properties;
                if ([properites containsObject:HMCharacteristicPropertyWritable] && [properites containsObject:HMCharacteristicPropertyReadable] && [properites containsObject:HMCharacteristicPropertySupportsEventNotification]) {
                    self.chaRx = cha;
                    [self.chaRx enableNotification:YES completionHandler:^(NSError * _Nullable error) {
                    }];
                    break;
                }
           }
        }
    }
    if (self.chaRx) {
        [self.chaRx readValueWithCompletionHandler:^(NSError * _Nullable error) {
            if (!error) {
                id value = self.chaRx.value;
                if ([value integerValue] == 0) {
                    [self.chaRx writeValue:@1 completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            [mySwitch setOn:YES];
                            cell.switchLbl.text = @"开";
                        }
                    }];
                }else {
                    [self.chaRx writeValue:@(0) completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            [mySwitch setOn:NO];
                            cell.switchLbl.text = @"关";
                        }
                    }];
                }
            }else {
                [self showTips:@"服务不可用，请稍后!"];
                NSLog(@"读取失败");
            }
        }];
    }

}

- (void)findAction:(id)sender
{
    [self.accessory identifyWithCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            [self showTips:@"暂时无法识别设备，请稍后!"];
        }
    }];
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
