//
//  SPConfigureChooseRoomController.h
//  SmartPlug
//
//  Created by patpat on 2017/11/9.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseController.h"
#import "SPConfigureZoneModel.h"
#import <HomeKit/HomeKit.h>

@interface SPConfigureChooseRoomController : SPBaseController
@property (strong, nonatomic)HMHomeManager * homeManager;
@property (nonatomic,strong) HMHome* currentHome;
@property (nonatomic,strong) NSMutableArray* datasArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
                         model:(SPConfigureZoneModel*)model;


@end
