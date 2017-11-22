//
//  SPRoomCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPRoomCell.h"
#import "Help.h"

@implementation SPRoomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bgView.backgroundColor = [UIColor blackColor];
    ViewRadius(_bgView, 10);
    _roomLbl.textColor = [UIColor whiteColor];
    _chooseImageView.hidden = YES;
    _chooseImageView.image = [UIImage imageNamed:@"choose_select"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
