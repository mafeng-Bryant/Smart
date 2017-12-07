//
//  SPXValueModel.h
//  SmartPlug
//
//  Created by patpat on 2017/12/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
   SPXValueModelTypeConsumption = 0,//消耗量
   SPXValueModelTypeCost = 1 //费用
}SPXValueModelType;

@interface SPXValueModel : NSObject
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,strong) NSString* value;//0.001
@property (nonatomic,assign) NSInteger hour;//0->0.001
@property (nonatomic,assign) SPXValueModelType type;


@end
