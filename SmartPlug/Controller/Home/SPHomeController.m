//
//  SPHomeController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPHomeController.h"
#import "SPTitleView.h"
#import "SPShowHomeCell.h"
#import "SPAddHomeCell.h"
#import <HomeKit/HomeKit.h>
#import "Help.h"
#import "SPHomeModel.h"
#import "MJRefresh.h"

@interface SPHomeController ()<HMHomeManagerDelegate>
@property (nonatomic,strong) UIView* headerView;
@property (nonatomic,strong) NSMutableArray* homeArray;
@property (strong, nonatomic)HMHomeManager * homeManager;

@end

@implementation SPHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeArray = [NSMutableArray array];
//    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 135, 36);
//   // [btn setImage:[UIImage imageNamed:@"btnbg"] forState:UIControlStateNormal];
//    [btn setTitleColor:@"sssss" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.navigationItem.titleView = btn;
    

    self.navigationItem.titleView = [[SPTitleView alloc]initWithFrame:CGRectMake(0, 0, 135, 36) title:@"家"];
    self.tableView.tableHeaderView = [self headerView];
    [SPShowHomeCell registerNibToTableView:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [SPAddHomeCell registerNibToTableView:self.tableView];
    [self getAllHomes];
    [self setRefrefesh];
}

- (void)setRefrefesh
{
    __unsafe_unretained UITableView *tableView = self.tableView;
    __weak typeof (self) weakSelf = self;
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getAllHomes];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_header endRefreshing];
        });
    }];

    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)getAllHomes
{
    [self.homeArray removeAllObjects];
    for (HMHome* home in self.homeManager.homes) {
        SPHomeModel* model = [[SPHomeModel alloc]init];
        model.home = home;
        if (home.isPrimary) {
            model.isSelect = YES;
        }else {
            model.isSelect = NO;
        }
        [self.homeArray addObject:model];
    }
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.homeArray.count) {
        
        SPAddHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPAddHomeCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else {
        SPHomeModel* model = self.homeArray[indexPath.row];
        SPShowHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPShowHomeCell reuseIdentifier] forIndexPath:indexPath];
        if ([model.home isPrimary]) {
            cell.homeLbl.text = [NSString stringWithFormat:@"%@(Primary)",model.home.name];
        }else {
            cell.homeLbl.text = model.home.name;
        }
        cell.chooseImageView.hidden  = model.isSelect?NO:YES;
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILongPressGestureRecognizer* tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(homeAction:)];
        [cell addGestureRecognizer:tap];
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeArray.count+1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.homeArray.count) {
        __weak typeof (self) weakSelf = self;
        UIAlertController* inputNameAlert = [UIAlertController alertControllerWithTitle:@"添加家" message:@"请输入家的名字" preferredStyle:1];
        [inputNameAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"家的名字";
        }];
        UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
        UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"添加" style:0 handler:^(UIAlertAction * _Nonnull action) {
            NSString* name = inputNameAlert.textFields.firstObject.text;
            //判断是否已经添加家
            BOOL isExit = NO;
            for (SPHomeModel* model in self.homeArray) {
                if ([model.home.name isEqualToString:name]) {
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
         [self.homeManager addHomeWithName:name completionHandler:^(HMHome * _Nullable home, NSError * _Nullable error) {
                if (!error) {
                    [weakSelf getAllHomes];
                }else {
                    NSLog(@"add home fail");
                }
            }];
        }];
        [inputNameAlert addAction:action1];
        [inputNameAlert addAction:action2];
        [self presentViewController:inputNameAlert animated:YES completion:nil];
    }else {
        SPHomeModel* model = self.homeArray[indexPath.row];
        [self clearChooseHome];
        if (!model.isSelect) {
            model.isSelect = YES;
        }
        [self.tableView reloadData];
    }
}

- (void)homeAction:(UILongPressGestureRecognizer*)tap
{
    SPShowHomeCell* cell = (SPShowHomeCell*)tap.view;
    SPHomeModel* model = cell.model;
    NSArray* operations = [self getOperations];
    __weak typeof (self) weakSelf = self;
    UIAlertController* homeList = [UIAlertController alertControllerWithTitle:@"" message:@"设置" preferredStyle:0];
    for (int a = 0; a<operations.count; a++) {
        NSString* name = operations[a];
        UIAlertAction* action1 = [UIAlertAction actionWithTitle:name style:0 handler:^(UIAlertAction * _Nonnull action) {
            if ([action.title isEqualToString:@"重命名"]) {
                UIAlertController* inputNameAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入修改的家的名称" preferredStyle:1];
                [inputNameAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.text = model.home.name;
                }];
                UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
                UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"重命名" style:0 handler:^(UIAlertAction * _Nonnull action) {
                    NSString* name = inputNameAlert.textFields.firstObject.text;
                    //判断是否已经添加家
                    BOOL isExit = NO;
                    for (SPHomeModel* model in self.homeArray) {
                        if ([model.home.name isEqualToString:name]) {
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
                    [model.home updateName:name completionHandler:^(NSError * _Nullable error) {
                        if (!error) {
                            [weakSelf getAllHomes];
                        }
                    }];
               }];
                [inputNameAlert addAction:action1];
                [inputNameAlert addAction:action2];
                [self presentViewController:inputNameAlert animated:YES completion:nil];
             }else if ([action.title isEqualToString:@"删除"]){
                [self.homeManager removeHome:model.home completionHandler:^(NSError * _Nullable error) {
                     if (!error) {
                         [weakSelf getAllHomes];
                     }
               }];
             }else if ([action.title isEqualToString:@"设置成主房间"]){
                if ([model.home isPrimary]) {
                    return ;
                }
                [self.homeManager updatePrimaryHome:model.home completionHandler:^(NSError * _Nullable error) {
                    if (!error) {
                        [weakSelf getAllHomes];
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

#pragma mark HMHomeManagerDelegate

- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager
{
    NSLog(@"更新了home");
    [self getAllHomes];
}

- (void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager
{
    NSLog(@"已经更新了primaryHome：%@",manager.primaryHome);
    [self getAllHomes];
}


- (void)homeManager:(HMHomeManager *)manager didAddHome:(HMHome *)home
{

    
    
}

- (void)homeManager:(HMHomeManager *)manager didRemoveHome:(HMHome *)home
{
    
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

- (UIView*)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
        _headerView.backgroundColor = [UIColor clearColor];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"家" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(10, 15, _headerView.frame.size.width - 20, 45);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0,-btn.frame.size.width+50, 0,0);
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.backgroundColor = [UIColor blackColor];
        ViewRadius(btn, VMargin10);
        [_headerView addSubview:btn];
    }
    return _headerView;
}

- (void)clearChooseHome
{
    for (SPHomeModel* model in self.homeArray) {
        model.isSelect = NO;
    }
}

- (NSArray*)getOperations
{
    return @[@"重命名",@"删除",@"设置成主房间"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
