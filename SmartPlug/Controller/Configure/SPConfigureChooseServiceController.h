//
//  SPConfigureChooseServiceController.h
//  SmartPlug
//
//  Created by patpat on 2017/11/9.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPBaseController.h"
#import "SPConfigureZoneModel.h"

@interface SPConfigureChooseServiceController : SPBaseController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
                         model:(SPConfigureZoneModel*)model;

@end
