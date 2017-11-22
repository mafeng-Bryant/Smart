//
//  SPActionSetTableViewInfo.h
//  SmartPlug
//
//  Created by patpat on 2017/11/10.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HomeKit/HomeKit.h>
#import "SPActionSetModel.h"

typedef enum {
    SPActionSetSectionTypeHeader
}SPActionSetSectionType;

typedef enum {
    SPActionSetRowTypeOpen,
    SPActionSetRowTypeClose,
}SPActionSetRowType;

@interface SPActionSetTableViewRowObject : NSObject
@property(nonatomic,assign)SPActionSetRowType type;
@property(nonatomic,assign)float height;
@property(nonatomic,strong)id object; //object
@property(nonatomic,assign)BOOL isOn;//状态
@property(nonatomic,strong)NSString *title;//title
@property(nonatomic,strong)NSString *value;//value
@property(nonatomic,strong)HMAccessory* accessory;
@property(nonatomic,strong)HMCharacteristicWriteAction* action;
@property(nonatomic,assign)BOOL hasValue;//是否已经设置值

@end

@interface SPActionSetTableViewSectionObject : NSObject
@property(nonatomic,assign)SPActionSetSectionType type;
@property(nonatomic,strong)NSMutableArray *rows;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,assign)float headerHeight;
@property(nonatomic,assign)float footerHeight;
@end

@interface SPActionSetTableViewInfo : NSObject
@property (nonatomic,strong) HMCharacteristicWriteAction* currentChooseAction;

- (void)configureData:(NSMutableArray *)data
                 home:(HMHome*)currentHome
                model:(SPActionSetModel*)model
              service:(HMService*)service
   containerViewWidth:(float)width;

@end
