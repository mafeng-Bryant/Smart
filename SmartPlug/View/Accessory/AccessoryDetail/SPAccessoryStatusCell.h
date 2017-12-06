//
//  SPAccessoryStatusCell.h
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCell.h"
#import "PPSwitch.h"
#import <HomeKit/HomeKit.h>

typedef enum {
  SPAcceessoryStatesTypePower = 0,
  SPAcceessoryStatesTypeAppliance = 1
}SPAcceessoryStatesType;

@protocol SPAccessoryStatusCellDelegate <NSObject>

- (void)updateCharacteristic:(HMAccessory*)accessory cha:(HMCharacteristic*)cha;

@end

@interface SPAccessoryStatusCell : SPCell
@property (weak, nonatomic) IBOutlet UILabel *statasLbl;
@property (weak, nonatomic) IBOutlet UILabel *switchLbl;
@property (weak, nonatomic) IBOutlet PPSwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong) HMCharacteristic* chaTx;//写特征
@property (nonatomic,strong) HMCharacteristic* chaRx;//读特征
@property (nonatomic,weak) id<SPAccessoryStatusCellDelegate>delegate;

- (void)configureData:(HMAccessory*)accessory type:(SPAcceessoryStatesType)type;


@end
