//
//  SPConfigureZonesCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPConfigureZonesCell.h"
#import "Help.h"
#import <HomeKit/HomeKit.h>

@implementation SPConfigureZonesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lineLbl.backgroundColor = RGB(241,243,242,1.0);
}

- (void)configureData:(SPConfigureZoneModel*)model
{
    NSArray* rooms = model.zone.rooms;
    if (rooms.count>0) {
        NSMutableArray* names = [NSMutableArray array];
        for (HMRoom* room in rooms) {
            [names addObject:room.name];
        }
        _roomLbl.text = [NSString stringWithFormat:@"房间: %@",[names componentsJoinedByString:@","]];
    }else {
        _roomLbl.text = @"房间:";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
