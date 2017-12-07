//
//  SPPowerHourModel.h
//  SmartPlug
//
//  Created by patpat on 2017/12/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+WHC_Model.h"

@interface SPPowerHourModel : NSObject<NSCoding>
@property (nonatomic,assign) NSInteger hour;
@property (nonatomic,strong) NSString* value;

+ (NSString *)whc_SqliteVersion;


@end
