//
//  SPAccessoryStatusCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPAccessoryStatusCell.h"
#import "Help.h"

@interface SPAccessoryStatusCell()<HMAccessoryDelegate>
{
    NSTimer* _timer;
}

@end

@implementation SPAccessoryStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bgView.backgroundColor = RGB(241,243,242,1.0);
    ViewRadius(_bgView, 5);
    _switchLbl.textColor = RGB(155,165,167,1.0);
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:)userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)configureData:(HMAccessory*)accessory type:(SPAcceessoryStatesType)type
{
    if (type == SPAcceessoryStatesTypePower) {
        NSArray* serviceArray = accessory.services;
        accessory.delegate = self;
        for (HMService* service in serviceArray) {
            NSArray* arr = service.characteristics;
            for (HMCharacteristic* cha in arr) {
                if ([cha.characteristicType isEqualToString:kAccessoryUUID]) {
                    NSArray* properites = cha.properties;
                    if ([properites containsObject:HMCharacteristicPropertyWritable] && [properites containsObject:HMCharacteristicPropertyReadable] && [properites containsObject:HMCharacteristicPropertySupportsEventNotification]) {
                        self.chaRx = cha;
                        [self.chaRx enableNotification:YES completionHandler:^(NSError * _Nullable error) {}];
                    }
                }
            }
        }
        if (self.chaRx) {
            [self.chaRx readValueWithCompletionHandler:^(NSError * _Nullable error) {
                if (!error) {
                    id value = self.chaRx.value;
                    NSNumber* on = (NSNumber*)value;
                    if ([on isEqualToNumber:@0]) {
                        [_mySwitch setOn:NO];
                        _switchLbl.text = @"关";
                    }else {
                        [_mySwitch setOn:YES];
                        _switchLbl.text = @"开";
                    }
                }else {
//                    NSLog(@"读取失败");
                }
            }];
        }
    }else if (type == SPAcceessoryStatesTypeAppliance){
        
        NSArray* serviceArray = accessory.services;
        accessory.delegate = self;
        for (HMService* service in serviceArray) {
            NSArray* arr = service.characteristics;
            for (HMCharacteristic* cha in arr) {
                 if ([cha.characteristicType isEqualToString:kAccessoryUseUUID]) {
                    NSArray* properites = cha.properties;
                    if ([properites containsObject:HMCharacteristicPropertyReadable] && [properites containsObject:HMCharacteristicPropertySupportsEventNotification]) {
                        self.chaTx = cha;
                        [self.chaTx enableNotification:YES completionHandler:^(NSError * _Nullable error) {}];
                    }
                }
            }
        }
        [self setPowerState];
    }
}

- (void)timerFired:(NSTimer*)timer
{
    [self setPowerState];
}

- (void)setPowerState
{
    if(self.chaTx){
    [self.chaTx readValueWithCompletionHandler:^(NSError * _Nullable error) {
        if(!error){
            id value = self.chaTx.value;
            NSNumber* on = (NSNumber*)value;
            if ([on isEqualToNumber:@0]) {
                [_mySwitch setOn:NO];
                _switchLbl.text = @"否";
            }else {
                [_mySwitch setOn:YES];
                _switchLbl.text = @"是";
            }
        }else {
            _switchLbl.text = @"否";
        }
    }];
  }
}

- (void)accessory:(HMAccessory *)accessory service:(HMService *)service didUpdateValueForCharacteristic:(HMCharacteristic *)characteristic
{
    if ([self.delegate respondsToSelector:@selector(updateCharacteristic:cha:)]) {
        [self.delegate updateCharacteristic:accessory cha:characteristic];
    }
}

-(void)dealloc
{
   [_timer invalidate];
    _timer = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
