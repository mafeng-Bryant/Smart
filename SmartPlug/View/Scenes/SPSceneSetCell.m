//
//  SPSceneSetCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/10.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPSceneSetCell.h"
#import "Help.h"

@implementation SPSceneSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bgView.backgroundColor = [UIColor blackColor];
    ViewRadius(_bgView, 10);
    _stateLbl.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
