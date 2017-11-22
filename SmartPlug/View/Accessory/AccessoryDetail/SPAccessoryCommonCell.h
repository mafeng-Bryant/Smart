//
//  SPAccessoryCommonCell.h
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCell.h"

@interface SPAccessoryCommonCell : SPCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *accessoryNameLbl;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
