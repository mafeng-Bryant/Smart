//
//  SPAddHomeCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPAddHomeCell.h"

@implementation SPAddHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _addHomeLbl.font = [UIFont systemFontOfSize:14];
    _addHomeLbl.textColor = [UIColor blackColor];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
