//
//  SPAccessoryCell.h
//  SmartPlug
//
//  Created by patpat on 2017/11/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCell.h"
#import "SPAccessoryInfo.h"

@interface SPAccessoryCell : SPCell

@property (weak, nonatomic) IBOutlet UILabel *tipsLbl;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *accessoryNameLbl;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong) SPAccessoryInfo* info;

- (void)configureData:(HMAccessory*)accessory;


@end
