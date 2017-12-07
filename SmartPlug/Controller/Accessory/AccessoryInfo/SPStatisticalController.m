//
//  SPStatisticalController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/30.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPStatisticalController.h"
#import "SPTitleView.h"
#import "Help.h"
#import "PPNSString+NSDate.h"
#import "SPPowerController.h"
#import "SPBaseNavigationController.h"
#import "SPPowerDataModel.h"
#import "SPDataManager.h"

@interface SPStatisticalController ()
{
    NSTimer* _timer;
    CGFloat _historyHourDataValue;
    NSDate *_historyDate;
    
}
@property (nonatomic,strong) HMCharacteristic* runTimeCharacteristic;//在线时间特征
@property (nonatomic,strong) HMCharacteristic* realtimeEnergyCharacteristic;//功率
@property (nonatomic,strong) HMCharacteristic* currentHourDataCharacteristic;//当前每小时功率值

@end

@implementation SPStatisticalController

-(void)loadView
{
    [super loadView];
    _gaugeView.maxValue = 2400.0;
    _gaugeView.showRangeLabels = YES;
    _gaugeView.rangeValues = @[@600,@1200,@1800,@2400.0];
    _gaugeView.rangeColors = @[RGB(255, 255,255,1.0),RGB(255, 255,255,1.0),RGB(255, 255,255,1.0),RGB(255, 255,255,1.0)];
    _gaugeView.rangeColors = @[[UIColor greenColor],[UIColor greenColor],[UIColor greenColor],[UIColor greenColor]];
    _gaugeView.unitOfMeasurement = @"WATTS";
    _gaugeView.showUnitOfMeasurement = YES;
    ViewRadius(_currentLowerLbl, 5);
    ViewRadius(_currentTimeLbl, 5);
    _currentLowerLbl.backgroundColor = [UIColor greenColor];
    _currentTimeLbl.backgroundColor = [UIColor orangeColor];
    _currentTimeLbl.titleLabel.font = _currentLowerLbl.titleLabel.font = [UIFont systemFontOfSize:12];
    [_currentTimeLbl setTitleColor:RGB(68, 68, 68, 1.0) forState:UIControlStateNormal];
    [_currentLowerLbl setTitleColor:RGB(68, 68, 68, 1.0) forState:UIControlStateNormal];
    [_currentLowerLbl setTitle:@"    当前小时电量:0瓦时    " forState:UIControlStateNormal];
    [_currentTimeLbl setTitle:@"    在线时间:0分0秒    " forState:UIControlStateNormal];
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(getAccessoryInfo:)userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTirtleViewText];
    [self setLeftItem];
    [self setRightItem];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_timer) {
        [_timer fire];
    }else {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(getAccessoryInfo:)userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)getAccessoryInfo:(NSTimer*)timer
{
    NSArray* serviceArray = self.accessory.services;
    for (HMService* service in serviceArray) {
        NSArray* arr = service.characteristics;
        for (HMCharacteristic* cha in arr) {
            if ([cha.characteristicType isEqualToString:kAccessoryRunning_Time]) {
                NSArray* properites = cha.properties;
                if ([properites containsObject:HMCharacteristicPropertyReadable] && [properites containsObject:HMCharacteristicPropertySupportsEventNotification]) {
                    self.runTimeCharacteristic = cha;
                    [self.runTimeCharacteristic enableNotification:YES completionHandler:^(NSError * _Nullable error) {
                    }];
                }
            }else if ([cha.characteristicType isEqualToString:kAccessoryRealTime_Energy]){
                NSArray* properites = cha.properties;
                if ([properites containsObject:HMCharacteristicPropertyReadable] && [properites containsObject:HMCharacteristicPropertySupportsEventNotification]) {
                    self.realtimeEnergyCharacteristic = cha;
                    [self.realtimeEnergyCharacteristic enableNotification:YES completionHandler:^(NSError * _Nullable error) {
                    }];
                }
            }else if ([cha.characteristicType isEqualToString:kAccessoryCurrentHourData]){
                NSArray* properites = cha.properties;
                if ([properites containsObject:HMCharacteristicPropertyReadable] && [properites containsObject:HMCharacteristicPropertySupportsEventNotification]) {
                    self.currentHourDataCharacteristic = cha;
                    [self.currentHourDataCharacteristic enableNotification:YES completionHandler:^(NSError * _Nullable error) {
                    }];
                }
           }
        }
    }
    
    if (self.runTimeCharacteristic) {
        id value = self.runTimeCharacteristic.value; //获取设备的负载在线运行时间
        NSInteger time = [(NSNumber*)value integerValue];
        [NSString getDayHourMinuteSeconds:time callBack:^(NSInteger days, NSInteger hours, NSInteger minutes, NSInteger seconds) {
            NSString* timeDescption = [NSString getRunningTime:days hour:hours minutes:minutes seconds:seconds];
            timeDescption = [NSString stringWithFormat:@"    在线时间:%@    ",timeDescption];
            [_currentTimeLbl setTitle:timeDescption forState:UIControlStateNormal];
        }];
    }
     if (self.realtimeEnergyCharacteristic) {
        id value = self.realtimeEnergyCharacteristic.value; //负载的功率
        CGFloat eneygy = [(NSNumber*)value floatValue];
        NSString* eneygyString = [NSString stringWithFormat:@"%.2f",eneygy];
        _gaugeView.showEnergy = eneygyString;
         _gaugeView.value = [eneygyString floatValue];
    }
    
    if (self.currentHourDataCharacteristic) {
        id value = self.currentHourDataCharacteristic.value; //负载的功率
        CGFloat dataEneygy = [(NSNumber*)value floatValue];
        if (dataEneygy < _historyHourDataValue) {
            //表示当前小时数据结束
            if ([[NSDate date] timeIntervalSinceNow] > [_historyDate timeIntervalSinceNow]) { //表示确实结束当前整点数据统计
                _historyHourDataValue = 0.0;
                _historyDate = nil;
            }
        }else {
            NSString* dataEneygyString = [NSString stringWithFormat:@"%.2f",dataEneygy];
            //获取当前整点的时间
            NSInteger hour = [[[NSDate date] formatHH] integerValue];
           //存储数据到数据库，按小时存储数据
            if (![SPDataManager sharedSPDataManager].hasCurrentDayData) {
             //创建存储对象
                SPPowerDataModel* model = [[SPPowerDataModel alloc]init];
                model.date = [NSDate date];
                model.day = [[NSDate date] formatYMD];
                //get current hour model
                for (SPPowerHourModel* hourModel in model.datas) {
                    if (hourModel.hour == hour) {
                        hourModel.value = dataEneygyString;
                    }
                }
                [[SPDataManager sharedSPDataManager] savePowerDataModel:model];
            }else {
                //更新数据源
                SPPowerDataModel* model = [[SPDataManager sharedSPDataManager] getCurrentDayModel];
                if (model) {
                    //get current hour model
                    for (SPPowerHourModel* hourModel in model.datas) {
                        if (hourModel.hour == hour) {
                            hourModel.value = dataEneygyString;
                        }
                    }
                   [[SPDataManager sharedSPDataManager] updateCurrentDayModel:model];
                }
            }
            dataEneygyString = [NSString stringWithFormat:@"    当前小时电量:%@瓦时    ",dataEneygyString];
            [_currentLowerLbl setTitle:dataEneygyString forState:UIControlStateNormal];
            _historyDate = [NSDate date];
      }
        _historyHourDataValue = dataEneygy;
    }
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

- (void)setRightItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:@selector(historyAction:)
  forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"历史记录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:14];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)historyAction:(UIButton*)btn
{
    SPPowerController* powerVC = [[SPPowerController alloc]initWithNibName:@"SPPowerController" bundle:nil];
    powerVC.accessory = self.accessory;
    SPBaseNavigationController* na = [[SPBaseNavigationController alloc]initWithRootViewController:powerVC];
    [self presentViewController:na animated:YES completion:nil];
}

- (void)closeAction:(UIButton*)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
