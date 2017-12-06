//
//  SPSettingNormalCell.m
//  SmartPlug
//
//  Created by patpat on 2017/12/3.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPSettingNormalCell.h"
#import "Help.h"

@implementation SPSettingNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lineLblHeight.constant = 1.0;
    _lineLbl.backgroundColor = RGB(241,243,242,1.0);
    _descptionLbl.textColor = RGB(155,165,167,1.0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
