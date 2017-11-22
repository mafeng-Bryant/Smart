//
//  SPAddRoomCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPAddRoomCell.h"
#import "Help.h"
#import "PPUIFont.h"

@implementation SPAddRoomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(self.addRoomBtn, 10);
    self.addRoomBtn.backgroundColor = [UIColor blackColor];
    [self.addRoomBtn setTitle:@"添加房间" forState:UIControlStateNormal];
    [self.addRoomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
