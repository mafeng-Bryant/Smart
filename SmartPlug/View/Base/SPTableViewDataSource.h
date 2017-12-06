//
//  SPTableViewDataSource.h
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <HomeKit/HomeKit.h>

@protocol SPTableViewDataSourceAccessory;


@interface SPTableViewDataSource : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic,assign) UITableView *tableView;
@property (nonatomic,assign)BOOL isRequesting;
@property (nonatomic,weak)id<SPTableViewDataSourceAccessory>dataSourceAccessory;
- (id)initWithTableView:(UITableView *)tableView;
- (void)requestDatas:(id)params finished:(void(^)(BOOL result))block;
- (BOOL)isEmpty;
- (void)destroy;

@end

@protocol SPTableViewDataSourceAccessory <NSObject>

@optional

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)presentsViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)changeServiceName:(HMService*)service callBlock:(void(^)(BOOL result))block;

- (void)hiddenTitleView;

- (void)showTitleView;

- (void)addZonesCallBlock:(void(^)(BOOL result))block;

- (void)renameZoneAndDelete:(id)object callBlock:(void(^)(BOOL result))block;

- (void)renameTriggerAndDelete:(id)object callBlock:(void (^)(BOOL))block;

- (void)addServiceGroup:(void(^)(BOOL result))block;

- (void)addActionSet:(id)object callBlock:(void(^)(BOOL result))block;

- (void)renameServiceAndDelete:(id)object callBlock:(void(^)(BOOL result))block;

- (void)addTrigger:(void(^)(BOOL result))block;

@end
