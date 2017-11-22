//
//  SPSceneSetActionController.h
//  SmartPlug
//
//  Created by patpat on 2017/11/10.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseController.h"
#import "SPActionSetModel.h"

@interface SPSceneSetActionController : SPBaseController
@property (nonatomic,strong) SPActionSetModel* model;
@property (nonatomic,strong) HMHome* currentHome;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
                   currentHome:(HMHome*)home
                         model:(SPActionSetModel*)model;

@end
