//
//  SPConfigureTriggersCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPConfigureTriggersCell.h"
#import "Help.h"

@implementation SPConfigureTriggersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lineHeight.constant = 0.5;
    _lineLbl.backgroundColor = RGB(241,243,242,1.0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
