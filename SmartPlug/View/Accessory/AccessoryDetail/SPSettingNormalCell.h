//
//  SPSettingNormalCell.h
//  SmartPlug
//
//  Created by patpat on 2017/12/3.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPCell.h"

@interface SPSettingNormalCell : SPCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *descptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *lineLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLblHeight;

@end
