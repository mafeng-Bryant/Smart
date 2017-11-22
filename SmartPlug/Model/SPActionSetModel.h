//
//  SPActionSetModel.h
//  SmartPlug
//
//  Created by patpat on 2017/11/9.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HomeKit/HomeKit.h>

typedef enum {
    SPActionSetTypeGoodMorning, //早上好
    SPActionSetTypeGoOut,//出门
    SPActionSetTypeComeBack,//到家
    SPActionSetTypeGoodNight,//晚安
    SPActionSetTypeCustom//自定义
}SPActionSetType;

@interface SPActionSetModel : NSObject
@property (nonatomic,strong) HMActionSet* actionSet;
@property (nonatomic,assign) SPActionSetType type;
@property (nonatomic,assign) NSInteger sort;


@end
