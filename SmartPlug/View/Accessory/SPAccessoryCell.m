//
//  SPAccessoryCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPAccessoryCell.h"
#import "Help.h"

@implementation SPAccessoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bgView.backgroundColor = [UIColor blackColor];
    _tipsLbl.textColor = [UIColor whiteColor];
    _accessoryNameLbl.textColor = [UIColor whiteColor];
    ViewRadius(_bgView, 10);
}

- (void)configureData:(HMAccessory*)accessory
{
    if (accessory.room && [accessory.room.name isEqualToString:@"Default Room"]) {
        _tipsLbl.text = @"未分配房间的设备";
    }else {
        _tipsLbl.text = [NSString stringWithFormat:@"该设备属于%@房间",accessory.room.name];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
