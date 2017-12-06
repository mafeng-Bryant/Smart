//
//  SPSetting.m
//  SmartPlug
//
//  Created by patpat on 2017/11/22.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPSetting.h"

@implementation SPSetting

SINGLETON_GCD(SPSetting);

-(id) init
{
    if (self = [super init]){
        _currencySymbol = @"￥";
        _numberOne = @"1";
        _numberTwo = @"00";
    }
    return self;
}


#pragma mark set and get mathod

-(SPPopUpManager *)popUpControllerManager
{
    if (!_popUpControllerManager) {
        _popUpControllerManager = [[SPPopUpManager alloc]init];
    }
    return _popUpControllerManager;
}

-(void)setCurrencySymbol:(NSString *)currencySymbol
{
    _currencySymbol = currencySymbol;
}

-(NSString *)chooseCharge
{
    if (isValidString(_numberOne) && isValidString(_numberTwo)) {
        return [NSString stringWithFormat:@"%@.%@",_numberOne,_numberTwo];
    }
    return @"0.00";
}

@end
