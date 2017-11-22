//
//  SPAccessoryInfo.h
//  SmartPlug
//
//  Created by patpat on 2017/11/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HomeKit/HomeKit.h>

static NSString* const kTypeRoom = @"room";
static NSString* const kTypeAccessory = @"accessory";
static NSString* const kTypeService = @"service";


@interface SPAccessoryInfo : NSObject
@property(nonatomic,strong) HMRoom* room;
@property(nonatomic,strong) HMAccessory* accessory;
@property(nonatomic,strong) NSString* type;
@property(nonatomic,assign) BOOL isSelected;//是否选中
@property(nonatomic,strong) HMService* service;


@end
