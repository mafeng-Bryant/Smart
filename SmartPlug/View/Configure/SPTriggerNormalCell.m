//
//  SPTriggerNormalCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPTriggerNormalCell.h"
#import "Help.h"

@implementation SPTriggerNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lineLbl.backgroundColor = RGB(205,210,211,1.0);
    _lineHeight.constant = 0.5;
    _nameLbl.textColor = [UIColor blackColor];
    _chooseImageView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
