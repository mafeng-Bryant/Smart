//
//  SPPowerTableViewInfo.h
//  SmartPlug
//
//  Created by patpat on 2017/12/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPYYModel.h"
#import "SPXValueModel.h"

@interface SPPowerTableViewInfo : NSObject
@property (nonatomic,strong) SPYYModel* yyModel;//y数据
@property (nonatomic,strong) NSMutableArray* valueDatas;
@property (nonatomic,strong) NSDate* date;

@end
