//
//  SPAccessoryDetailController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/7.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPAccessoryDetailController.h"
#import "SPTitleView.h"
#import "SPAccessoryDataSource.h"
#import "SPAccessoryTableViewInfo.h"

@interface SPAccessoryDetailController ()<SPTableViewDataSourceAccessory>
@property (nonatomic,strong) SPAccessoryDataSource* dataSource;
@property (nonatomic,strong) SPAccessoryTableViewInfo* tableViewInfo;

@end

@implementation SPAccessoryDetailController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTirtleViewText];
    [self setLeftItem];
    [self dataSource];
}

#pragma mark set and get

-(SPAccessoryDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[SPAccessoryDataSource alloc]initWithTableView:self.tableView accessory:self.accessory tableViewInfo:self.tableViewInfo];
        _dataSource.dataSourceAccessory = self;
    }
    return _dataSource;
}

-(SPAccessoryTableViewInfo *)tableViewInfo
{
    if (!_tableViewInfo) {
        _tableViewInfo = [[SPAccessoryTableViewInfo alloc]init];
    }
    return _tableViewInfo;
}

- (void)setTirtleViewText
{
    SPTitleView* view = [[SPTitleView alloc]initWithFrame:CGRectZero title:self.accessory.name];
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

#pragma mark SPTableViewDataSourceAccessory

- (void)changeServiceName:(HMService*)service callBlock:(void(^)(BOOL result))block
{
    UIAlertController *inputNameAlter = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入服务名称,这个名称能够被Siri识别" preferredStyle:1];
    [inputNameAlter addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.text = service.name;
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"重命名" style:0 handler:^(UIAlertAction * _Nonnull action) {
         NSString *newName =inputNameAlter.textFields.firstObject.text;
         [service updateName:newName completionHandler:^(NSError * _Nullable error) {
            if (!error) {
                block(YES);
            }
        }];
    }];
    [inputNameAlter addAction:action1];
    [inputNameAlter addAction:action2];
    [self presentViewController:inputNameAlter animated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
