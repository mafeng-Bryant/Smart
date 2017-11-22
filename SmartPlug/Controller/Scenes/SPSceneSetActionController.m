//
//  SPSceneSetActionController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/10.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPSceneSetActionController.h"
#import "SPTitleView.h"
#import <HomeKit/HomeKit.h>
#import "SPAccessoryInfo.h"
#import "SPSceneSetActionDataSource.h"
#import "SPActionSetTableViewInfo.h"

@interface SPSceneSetActionController ()<HMHomeManagerDelegate,SPTableViewDataSourceAccessory>
@property (strong, nonatomic) HMHomeManager * homeManager;
@property (nonatomic,strong) NSMutableArray* datasArray;
@property (nonatomic,strong) SPAccessoryInfo* info;
@property (nonatomic,strong) SPSceneSetActionDataSource* dataSource;
@property (nonatomic,strong) SPActionSetTableViewInfo* tableViewInfo;

@end

@implementation SPSceneSetActionController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
                   currentHome:(HMHome*)home
                         model:(SPActionSetModel*)model
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.model = model;
        self.currentHome = home;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleViewText];
    [self setLeftItem];
    [self dataSource];
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

- (void)closeAction:(UIButton*)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)initDatas
{
    if (_dataSource) {
        [_dataSource setCurrentChooseHome:self.currentHome];
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
    self.navigationItem.titleView = [[SPTitleView alloc]initWithFrame:CGRectZero title:self.model.actionSet.name];
    [self setChooseActionSet];
}

-(SPActionSetTableViewInfo *)tableViewInfo
{
    if (!_tableViewInfo) {
        _tableViewInfo = [[SPActionSetTableViewInfo alloc]init];
    }
    return _tableViewInfo;
}

-(SPSceneSetActionDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[SPSceneSetActionDataSource alloc] initWithTableView:self.tableView
                                                                      model:self.model
                                                              tableViewInfo:self.tableViewInfo];
        _dataSource.dataSourceAccessory = self;
    }
    return _dataSource;
}

- (void)setChooseActionSet
{
    if (self.model.actionSet.actions >0) {
        for (HMCharacteristicWriteAction* action in self.model.actionSet.actions) {
            self.tableViewInfo.currentChooseAction = action;
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
