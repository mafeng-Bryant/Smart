//
//  SPAccessoryCommonCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPAccessoryCommonCell.h"
#import "Help.h"

@implementation SPAccessoryCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bgView.backgroundColor = RGB(241,243,242,1.0);
    ViewRadius(_bgView, 5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
