//
//  SPConfigureChooseRoomController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/9.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPConfigureChooseRoomController.h"
#import "SPTitleView.h"
#import "SPConfigureZoneModel.h"
#import "SPAccessoryInfo.h"
#import "SPAddRoomCell.h"
#import "SPRoomCell.h"
#import "Help.h"

@interface SPConfigureChooseRoomController ()<HMHomeManagerDelegate>
@property (nonatomic,strong) SPConfigureZoneModel* model;
@property (nonatomic,strong) UIView* headerView;

@end

@implementation SPConfigureChooseRoomController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
                         model:(SPConfigureZoneModel*)model
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTirtleViewText];
    [SPRoomCell registerNibToTableView:self.tableView];
    [SPAddRoomCell registerNibToTableView:self.tableView];
    self.datasArray = [NSMutableArray array];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [self headerView];
    [self setLeftItem];
    [self.tableView reloadData];
}

- (void)setTirtleViewText
{
    for (HMHome* home in self.homeManager.homes) {
        if (home.isPrimary) {
            _currentHome = home;
        }
    }
    SPTitleView* view = [[SPTitleView alloc]initWithFrame:CGRectZero title:self.model.zone.name];
    view.titleLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:12];
    self.navigationItem.titleView = view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPAccessoryInfo* info = self.datasArray[indexPath.row];
    SPRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPRoomCell reuseIdentifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.roomLbl.text = info.room.name;
    cell.info = info;
    cell.chooseImageView.hidden = info.isSelected?NO:YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SPAccessoryInfo* info = self.datasArray[indexPath.row];
    __weak typeof (self) weakSelf = self;
    info.isSelected = !info.isSelected;
    if (info.isSelected) {
         [self.model.zone addRoom:info.room completionHandler:^(NSError * _Nullable error) {
             if (!error) {
                 [weakSelf updateCurrentHomeRooms:weakSelf.currentHome];
             }
        }];
    }else {
        //find room
        HMRoom* _removeRoom = nil;
        for (HMRoom* room1 in self.model.zone.rooms) {
            if ([room1.name isEqualToString:info.room.name]) {
                _removeRoom = room1;
                break;
            }
        }
        if (_removeRoom) {
            [self.model.zone removeRoom:_removeRoom completionHandler:^(NSError * _Nullable error) {
                if (!error) {
                    [weakSelf updateCurrentHomeRooms:weakSelf.currentHome];
                }
            }];
        }
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

- (void)updateCurrentHomeRooms:(HMHome*)home
{
    [self.datasArray removeAllObjects];
    for (HMRoom* room in self.currentHome.rooms) {
        SPAccessoryInfo* info = [[SPAccessoryInfo alloc]init];
        info.room = room;
        info.type = kTypeRoom;
        info.isSelected = NO;
        NSArray* zoneRooms = self.model.zone.rooms;
        for (HMRoom* room2 in zoneRooms) {
            if ([room2.name isEqualToString:room.name]) {
                info.isSelected = YES;
                break;
            }
        }
        [self.datasArray addObject:info];
    }
    [self.tableView reloadData];
}

- (void)initDatas
{
    [self updateCurrentHomeRooms:self.currentHome];
}

#pragma mark HMHomeManagerDelegate

- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager
{
    [self setTirtleViewText];
    [self initDatas];
}

- (void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager
{
    [self setTirtleViewText];
    [self initDatas];
}

#pragma mark set and get method

- (HMHomeManager *)homeManager
{
    if (!_homeManager) {
        _homeManager =  [HMHomeManager new];
        _homeManager.delegate = self;
    }
    return _homeManager;
}

- (void)setLeftItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 24, 24);
    [btn addTarget:self action:@selector(closeAction:)
    forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (UIView*)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 80)];
        _headerView.backgroundColor = [UIColor clearColor];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"选择房间" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(25, 10, _headerView.frame.size.width - 50, 60);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0,-btn.frame.size.width+100, 0,0);
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.backgroundColor = [UIColor blackColor];
        ViewRadius(btn, VMargin10);
        [_headerView addSubview:btn];
    }
    return _headerView;
}

- (void)closeAction:(UIButton*)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
