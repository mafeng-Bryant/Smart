//
//  SPHomeModel.h
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HomeKit/HomeKit.h>

@interface SPHomeModel : NSObject
@property (nonatomic,strong) HMHome* home;
@property (nonatomic,assign) BOOL isSelect;

@end
