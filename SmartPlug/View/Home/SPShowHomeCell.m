//
//  SPShowHomeCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPShowHomeCell.h"

@implementation SPShowHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _homeLbl.font = [UIFont systemFontOfSize:14];
    _homeLbl.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
