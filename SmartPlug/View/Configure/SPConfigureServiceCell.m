//
//  SPConfigureServiceCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPConfigureServiceCell.h"
#import "Help.h"

@implementation SPConfigureServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lineLbl.backgroundColor = RGB(241,243,242,1.0);
}

- (void)configureData:(SPConfigureZoneModel*)model
{
    _serviceLbl.text = model.serviceGroup.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
