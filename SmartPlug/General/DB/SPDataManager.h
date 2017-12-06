//
//  SPDataManager.h
//  SmartPlug
//
//  Created by patpat on 2017/12/3.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPSynchTimeModel.h"

@interface SPDataManager : NSObject

+ (SPDataManager *)sharedSPDataManager;

//获取同步时间的对象
- (SPSynchTimeModel*)getTimeModel;

- (BOOL)updtaTime:(SPSynchTimeModel*)object;




@end
