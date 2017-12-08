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
#import "AFNetWorking.h"
#import "SPPopUpView.h"
#import "Help.h"
#import "SPSetting.h"

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
    [self getAccessoryInfo];
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

- (void)getAccessoryInfo
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    if (@available(iOS 11.0, *)) {
        NSDictionary *parameters = @{@"model":self.accessory.model,@"firmware":self.accessory.firmwareVersion?self.accessory.firmwareVersion:@"0.0",
                                            @"sn":self.accessory.identifier.UUIDString
                                            };
        [manager POST:kUpdateAccessoryUrl parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
         } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
            NSDictionary* info = responseObject[@"content"];
            CGFloat version = [info[@"last_fv"] floatValue];
             NSString* url = responseObject[@"url"];
            if (version > [self.accessory.firmwareVersion floatValue]) {
                [SPPopUpView showAlertStyleWithTitle:@"您的产品可以升级啦!" message:@"您的产品在升级过程中会出现离线的现象，升级成功后可能需要您对设备进行重置，在升级期间请不要离开opso home" okButtonTitle:@"确定" cancelButtonTitle:@"取消" clickBlock:^(NSUInteger clickIndex) {
                    [SPSetting sharedSPSetting].updateVersion = YES;
                    [SPSetting sharedSPSetting].otaUrl = url;
                    if (clickIndex ==1) { //升级固件
                        if (self.universalDelegate && [self.universalDelegate respondsToSelector:@selector(callBack:withObject:)]) {
                            [self.universalDelegate callBack:self withObject:nil];
                        }
                    }
                }];
            }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error = %@",error.description);
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
