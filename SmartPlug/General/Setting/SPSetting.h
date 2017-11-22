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

+ (SPSetting *)sharedSPSetting;

@end
