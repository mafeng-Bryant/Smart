//
//  SPTriggerNormalCell.h
//  SmartPlug
//
//  Created by patpat on 2017/11/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPCell.h"

@interface SPTriggerNormalCell : SPCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet UILabel *lineLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;

@end
