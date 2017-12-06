//
//  SPSetting.h
//  SmartPlug
//
//  Created by patpat on 2017/11/22.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Help.h"
#import "SPPopUpManager.h"

@interface SPSetting : NSObject
@property (nonatomic,strong) SPPopUpManager* popUpControllerManager;
@property (nonatomic,strong) NSString* currencySymbol;
@property (nonatomic,strong) NSString* numberOne;
@property (nonatomic,strong) NSString* numberTwo;
@property (nonatomic,strong) NSString* chooseCharge;

+ (SPSetting *)sharedSPSetting;

@end
