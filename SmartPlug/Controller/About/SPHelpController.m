//
//  SPHelpController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPHelpController.h"
#import "SPTitleView.h"
#import "Help.h"
#import "SPHelpDataSource.h"
#import "SPHelpTableViewInfo.h"

@interface SPHelpController ()<SPTableViewDataSourceAccessory>
@property (nonatomic,strong) UIView* headerView;
@property (nonatomic,strong)SPHelpDataSource* dataSource;
@property (nonatomic,strong)SPHelpTableViewInfo* tableViewInfo;

@end

@implementation SPHelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[SPTitleView alloc]initWithFrame:CGRectZero title:@"帮助"];
    [self setLeftItem];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = [self headerView];
    [self dataSource];
}


-(SPHelpDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[SPHelpDataSource alloc]initWithTableView:self.tableView
                                                   tableViewInfo:self.tableViewInfo];
        _dataSource.dataSourceAccessory = self;
    }
    return _dataSource;
}

-(SPHelpTableViewInfo *)tableViewInfo
{
    if (!_tableViewInfo) {
        _tableViewInfo = [[SPHelpTableViewInfo alloc]init];
    }
    return _tableViewInfo;
}

- (UIView*)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 60)];
        _headerView.backgroundColor = [UIColor clearColor];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"常见问题" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(20, 15, _headerView.frame.size.width - 40, 45);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0,-btn.frame.size.width+110, 0,0);
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.backgroundColor = [UIColor blackColor];
        ViewRadius(btn, VMargin10);
        [_headerView addSubview:btn];
    }
    return _headerView;
}

- (void)setLeftItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
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
