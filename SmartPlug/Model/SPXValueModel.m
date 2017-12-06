//
//  SPXValueModel.m
//  SmartPlug
//
//  Created by patpat on 2017/12/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPXValueModel.h"

@implementation SPXValueModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type = SPXValueModelTypeConsumption;
    }
    return self;
}

@end
