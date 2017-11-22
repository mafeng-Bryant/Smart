//
//  SPSetting.m
//  SmartPlug
//
//  Created by patpat on 2017/11/22.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPSetting.h"

@implementation SPSetting

SINGLETON_GCD(SPSetting);

-(id) init
{
    if (self = [super init]){
    }
    return self;
}


#pragma mark set and get mathod

-(SPPopUpManager *)popUpControllerManager
{
    if (!_popUpControllerManager) {
        _popUpControllerManager = [[SPPopUpManager alloc]init];
    }
    return _popUpControllerManager;
}


@end
