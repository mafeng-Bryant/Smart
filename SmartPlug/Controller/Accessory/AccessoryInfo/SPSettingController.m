//
//  SPSettingController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/30.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPSettingController.h"
#import "SPTitleView.h"
#import "SPSettingDataSource.h"

@interface SPSettingController ()
@property (nonatomic,strong) SPSettingDataSource* dataSource;
@property (nonatomic,strong) SPSettingTableViewInfo* tableViewInfo;

@end

@implementation SPSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTirtleViewText];
    [self setLeftItem];
    [self dataSource];
}

-(SPSettingDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[SPSettingDataSource alloc]initWithTableView:self.tableView accessory:self.accessory tableViewInfo:self.tableViewInfo];
    }
    return _dataSource;
}

-(SPSettingTableViewInfo *)tableViewInfo
{
    if (!_tableViewInfo) {
        _tableViewInfo = [[SPSettingTableViewInfo alloc]init];
    }
    return _tableViewInfo;
}

- (void)setTirtleViewText
{
    SPTitleView* view = [[SPTitleView alloc]initWithFrame:CGRectZero title:@"设置"];
    self.navigationItem.titleView = view;
}

- (void)setLeftItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 24, 24);
    [btn addTarget:self action:@selector(closeAction:)
  forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:14];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
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
