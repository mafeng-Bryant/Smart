//
//  SPSynchTimeModel.h
//  SmartPlug
//
//  Created by patpat on 2017/12/3.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHC_ModelSqlite.h"

@interface SPSynchTimeModel : NSObject<WHC_SqliteInfo>
@property (nonatomic,strong) NSString* dateString;//同步时间

+ (NSString *)whc_SqliteVersion;

@end
