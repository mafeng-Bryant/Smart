//
//  SPAccessoryController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPAccessoryController.h"
#import "SPTitleView.h"
#import <HomeKit/HomeKit.h>
#import "Help.h"
#import "SPAddRoomCell.h"
#import "SPRoomCell.h"
#import "SPAccessoryCell.h"
#import "SPAccessoryInfo.h"
#import "SPAccessoryDetailController.h"
#import "SPBaseNavigationController.h"
#import "MJRefresh.h"
#import "SPSettingController.h"
#import "SPStatisticalController.h"

@interface SPAccessoryController()<HMHomeManagerDelegate,HMAccessoryBrowserDelegate,UniversalDelegate>
{
    UITabBarController* _tabBarController;
}
@property (strong, nonatomic)HMHomeManager * homeManager;
@property (nonatomic,strong) HMHome* currentHome;
@property (nonatomic,strong) NSMutableArray* datasArray;
@property (nonatomic,strong) SPAccessoryInfo* info;
@property (strong, nonatomic)HMAccessoryBrowser *broswer;
@property (nonatomic,strong) NSMutableArray* accessoryArray;

@end

@implementation SPAccessoryController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.datasArray = [NSMutableArray array];
    self.accessoryArray = [NSMutableArray array];
    [self setTitleViewText];
    [self setRightItem];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [SPAddRoomCell registerNibToTableView:self.tableView];
    [SPRoomCell registerNibToTableView:self.tableView];
    [SPAccessoryCell registerNibToTableView:self.tableView];
    [self setRefrefesh];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.datasArray.count) {
        
        SPAddRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPAddRoomCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.addRoomBtn addTarget:self action:@selector(addRoom:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    SPAccessoryInfo* info = self.datasArray[indexPath.row];
    if ([info.type isEqualToString:kTypeRoom]) {
        SPRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPRoomCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.roomLbl.text = info.room.name;
        cell.info = info;
        UILongPressGestureRecognizer* tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(roomAction:)];
        [cell addGestureRecognizer:tap];
        return cell;
        
    }else if ([info.type isEqualToString:kTypeAccessory]){
       SPAccessoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPAccessoryCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryNameLbl.text = info.accessory.name;
        cell.info = info;
        [cell configureData:info.accessory];
        UILongPressGestureRecognizer* tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(accessoryAction:)];
        [cell addGestureRecognizer:tap];
        return cell;
      }
      return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.datasArray.count) {
        return 60.0;
    }
    SPAccessoryInfo* info = self.datasArray[indexPath.row];
    if ([info.type isEqualToString:kTypeRoom]) {
        return 60.0f;
    }else if ([info.type isEqualToString:kTypeAccessory]){
        return 80.0f;
    }
   return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasArray.count+1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SPAccessoryInfo* info = self.datasArray[indexPath.row];
    if ([info.type isEqualToString:kTypeAccessory]) {
        SPAccessoryDetailController* detailVC = [[SPAccessoryDetailController alloc]initWithNibName:@"SPAccessoryDetailController" bundle:nil];
        detailVC.accessory = info.accessory;
        detailVC.universalDelegate = self;
         SPBaseNavigationController* na = [[SPBaseNavigationController alloc]initWithRootViewController:detailVC];
        UIImage* homeImage = Image(@"home");
        UITabBarItem *tabItem = [[UITabBarItem alloc]initWithTitle:@"控制" image:homeImage selectedImage:homeImage];
        na.tabBarItem = tabItem;

        SPStatisticalController* detailVC2 = [[SPStatisticalController alloc]initWithNibName:@"SPStatisticalController" bundle:nil];
        detailVC2.accessory = info.accessory;
        SPBaseNavigationController* na2 = [[SPBaseNavigationController alloc]initWithRootViewController:detailVC2];
        UITabBarItem *tabItem2 = [[UITabBarItem alloc]initWithTitle:@"统计制" image:homeImage selectedImage:homeImage];
        na2.tabBarItem = tabItem2;
        
        SPSettingController* detailVC3 = [[SPSettingController alloc]initWithNibName:@"SPSettingController" bundle:nil];
        detailVC3.accessory = info.accessory;
        SPBaseNavigationController* na3 = [[SPBaseNavigationController alloc]initWithRootViewController:detailVC3];
        UITabBarItem *tabItem3 = [[UITabBarItem alloc]initWithTitle:@"设置" image:homeImage selectedImage:homeImage];
        na3.tabBarItem = tabItem3;
        
        UITabBarController* tabBarController = [[UITabBarController alloc]init];
        [tabBarController.tabBar setTintColor:[UIColor whiteColor]];
        tabBarController.tabBar.backgroundImage = Image(@"tabbarbg");
        tabBarController.tabBar.layer.borderWidth = 0.25;
        tabBarController.tabBar.layer.borderColor = [UIColor blackColor].CGColor;
        [tabBarController.tabBar setClipsToBounds:YES];
        [tabBarController setViewControllers:@[na,na2,na3] animated:NO];
        tabBarController.tabBar.barTintColor = [UIColor whiteColor];
        _tabBarController = tabBarController;
        [self presentViewController:tabBarController animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,0.1f)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)addRoom:(UIButton*)btn
{
    __weak typeof (self) weakSelf = self;
    UIAlertController *inputNameAlter = [UIAlertController alertControllerWithTitle:@"添加房间" message:@"请输入房间名称" preferredStyle:1];
    [inputNameAlter addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"房间名称";
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"添加" style:0 handler:^(UIAlertAction * _Nonnull action) {
        NSString *newName =inputNameAlter.textFields.firstObject.text;
        [self.currentHome addRoomWithName:newName completionHandler:^(HMRoom * _Nullable room, NSError * _Nullable error) {
            if (!error) {
                 [weakSelf updateCurrentHomeRooms:weakSelf.currentHome];
            }
        }];
    }];
    [inputNameAlter addAction:action1];
    [inputNameAlter addAction:action2];
    [self presentViewController:inputNameAlter animated:YES completion:^{}];
}

- (void)sortDatas
{
    NSMutableArray* sortDatas = [NSMutableArray array];
    for ( SPAccessoryInfo* info in self.datasArray) {
        if ([info.type isEqualToString:kTypeRoom]) {
            [sortDatas addObject:info];
        }
    }
    for (SPAccessoryInfo* info in self.datasArray) {
        if ([info.type isEqualToString:kTypeAccessory]) {
            [sortDatas addObject:info];
        }
    }
    self.datasArray = [NSMutableArray arrayWithArray:sortDatas];
    [self.tableView reloadData];
}

- (void)updateCurrentHomeRooms:(HMHome*)home
{
    for (HMRoom* room in self.currentHome.rooms) {
        SPAccessoryInfo* info = [[SPAccessoryInfo alloc]init];
        info.room = room;
        info.type = kTypeRoom;
        if (![self isExistRoom:room]) {
            [self.datasArray addObject:info];
        }
    }
    for (HMAccessory* accessory in self.currentHome.accessories) {
        SPAccessoryInfo* info = [[SPAccessoryInfo alloc]init];
        info.accessory = accessory;
        info.type = kTypeAccessory;
        if (![self isExistAccessory:accessory]) {
            [self.datasArray addObject:info];
        }
    }
    [self sortDatas];
}

- (BOOL)isExistRoom:(HMRoom*)currentRoom
{
    BOOL isExist = NO;
    for (SPAccessoryInfo* info in self.datasArray) {
        if ([info.room.name isEqualToString:currentRoom.name]) {
            isExist = YES;
            break;
        }
    }
    return isExist;
}

- (BOOL)isExistAccessory:(HMAccessory*)accessory
{
    BOOL isExist = NO;
    for (SPAccessoryInfo* info in self.datasArray) {
        if ([info.accessory.name isEqualToString:accessory.name]) {
            isExist = YES;
            break;
        }
    }
    return isExist;
}

- (void)roomAction:(UILongPressGestureRecognizer*)tap
{
    SPRoomCell* cell = (SPRoomCell*)tap.view;
    SPAccessoryInfo* info = cell.info;
    NSArray* operations = [self getOperations];
    __weak typeof (self) weakSelf = self;
    UIAlertController* homeList = [UIAlertController alertControllerWithTitle:@"" message:@"设置" preferredStyle:0];
    for (int a = 0; a<operations.count; a++) {
        NSString* name = operations[a];
        UIAlertAction* action1 = [UIAlertAction actionWithTitle:name style:0 handler:^(UIAlertAction * _Nonnull action) {
            if ([action.title isEqualToString:@"重命名"]) {
                UIAlertController* inputNameAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入房间名称" preferredStyle:1];
                [inputNameAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.text = info.room.name;
                }];
                UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
                UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"重命名" style:0 handler:^(UIAlertAction * _Nonnull action) {
                    NSString* name = inputNameAlert.textFields.firstObject.text;
                    BOOL isExit = NO;
                    for (HMRoom* room in self.currentHome.rooms) {
                        if ([room.name isEqualToString:name]) {
                            isExit = YES;
                            break;
                        }
                    }
                    if (isExit) {
                        UIAlertController* inputNameAlert = [UIAlertController alertControllerWithTitle:@"错误" message:@"已有相似名称" preferredStyle:1];
                        UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"好的" style:0 handler:nil];
                        [inputNameAlert addAction:action1];
                        [self presentViewController:inputNameAlert animated:YES completion:nil];
                        return ;
                    }
                    [info.room updateName:name completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            [weakSelf updateCurrentHomeRooms:weakSelf.currentHome];
                        }
                    }];
                }];
                [inputNameAlert addAction:action1];
                [inputNameAlert addAction:action2];
                [self presentViewController:inputNameAlert animated:YES completion:nil];
            }else if ([action.title isEqualToString:@"删除"]){
                [self.currentHome removeRoom:info.room completionHandler:^(NSError * _Nullable error) {
                    if (!error) {
                        [self.datasArray removeObject:info];
                        [weakSelf updateCurrentHomeRooms:weakSelf.currentHome];
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

- (void)accessoryAction:(UILongPressGestureRecognizer*)tap
{
    SPAccessoryCell* cell = (SPAccessoryCell*)tap.view;
    SPAccessoryInfo* info = cell.info;
    NSArray* operations = [self getAccessoryOperations];
    HMHome* currentHome = self.currentHome;
    __weak typeof (self) weakSelf = self;
    UIAlertController* homeList = [UIAlertController alertControllerWithTitle:@"" message:@"设置" preferredStyle:0];
    for (int a = 0; a<operations.count; a++) {
        NSString* name = operations[a];
        UIAlertAction* action1 = [UIAlertAction actionWithTitle:name style:0 handler:^(UIAlertAction * _Nonnull action) {
            if ([action.title isEqualToString:@"重命名"]) {
                UIAlertController* inputNameAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入新名称" preferredStyle:1];
                [inputNameAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.text = info.accessory.name;
                }];
                UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
                UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"重命名" style:0 handler:^(UIAlertAction * _Nonnull action) {
                    NSString* name = inputNameAlert.textFields.firstObject.text;
                    [info.accessory updateName:name completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            NSLog(@"更新设备名称成功");
                            [weakSelf updateCurrentHomeRooms:weakSelf.currentHome];
                        }
                    }];
             }];
                [inputNameAlert addAction:action1];
                [inputNameAlert addAction:action2];
                [self presentViewController:inputNameAlert animated:YES completion:nil];
            }else if ([action.title isEqualToString:@"删除"]){
                [currentHome removeAccessory:info.accessory completionHandler:^(NSError * _Nullable error) {
                    if (!error) {
                        [self.datasArray removeObject:info];
                        [weakSelf updateCurrentHomeRooms:weakSelf.currentHome];
                    }
                }];
            }else if ([action.title isEqualToString:@"转移设备"]){
               
                NSArray* rooms = self.currentHome.rooms;
                __weak typeof (self) weakSelf = self;
                UIAlertController* homeList = [UIAlertController alertControllerWithTitle:@"转移设备" message:@"请选择一个房间" preferredStyle:0];
                for (int a = 0; a<rooms.count; a++) {
                    HMRoom* selectRoom = rooms[a];
                    UIAlertAction* action1 = [UIAlertAction actionWithTitle:selectRoom.name style:0 handler:^(UIAlertAction * _Nonnull action) {
                        if ([info.room.name isEqualToString:selectRoom.name]) {
                            return ;
                        }
                     //将设备分配到指定房间
                        [currentHome assignAccessory:info.accessory toRoom:selectRoom completionHandler:^(NSError * _Nullable error) {
                            if (!error) {
                                [weakSelf updateCurrentHomeRooms:weakSelf.currentHome];
                            }
                        }];
                    }];
                    [homeList addAction:action1];
                }
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
                }];
                [homeList addAction:action1];
                [self presentViewController:homeList animated:YES completion:^{}];
           }else if ([action.title isEqualToString:@"标记"]){
           //
               
                
            }
        }];
        [homeList addAction:action1];
    }
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    [homeList addAction:action1];
    [self presentViewController:homeList animated:YES completion:^{}];
}

- (void)initDatas
{
    [self updateCurrentHomeRooms:self.currentHome];
}

- (NSArray*)getOperations
{
    return @[@"重命名",@"删除"];
}

- (NSArray*)getAccessoryOperations
{
    return @[@"重命名",@"标记",@"转移设备",@"删除"];
}

- (void)setRefrefesh
{
    __unsafe_unretained UITableView *tableView = self.tableView;
    __weak typeof (self) weakSelf = self;
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf updateCurrentHomeRooms:weakSelf.currentHome];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_header endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
}

#pragma mark HMHomeManagerDelegate

- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager
{
    [self setTitleViewText];
    [self initDatas];
}

- (void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager
{
    [self setTitleViewText];
    [self initDatas];
}

- (void)setRightItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(addAccessory:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addAccessory:(UIButton*)btn
{
    __weak typeof (self) weakSelf = self;
    if (@available(iOS 10.0, *)) {
        [self.currentHome addAndSetupAccessoriesWithCompletionHandler:^(NSError * _Nullable error) {
            if (!error) {
                [weakSelf updateCurrentHomeRooms:weakSelf.currentHome];
            }
        }];
    }
}

#pragma mark UniversalDelegate

- (void)callBack:(id)info withObject:(id)info1
{
    if (info && [info isKindOfClass:[SPAccessoryDetailController class]]) {
        _tabBarController.selectedIndex = 2;
    }
}

#pragma mark - HMAccessoryBrowserDelegate
- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didFindNewAccessory:(HMAccessory *)accessory
{
    //获取到新硬件
}

- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didRemoveNewAccessory:(HMAccessory *)accessory
{
    //移除新硬件
}

#pragma mark set and get method

- (HMHomeManager *)homeManager
{
    if (_homeManager == nil) {
        _homeManager =  [HMHomeManager new];
        _homeManager.delegate = self;
    }
    return _homeManager;
}

- (HMAccessoryBrowser *)broswer{
    
    if (_broswer == nil) {
        _broswer = [HMAccessoryBrowser new];
        _broswer.delegate = self;
    }
    return _broswer;
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


@end
