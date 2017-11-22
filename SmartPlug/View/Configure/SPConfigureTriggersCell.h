//
//  SPConfigureTriggersCell.h
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCell.h"
#import "SPConfigureZoneModel.h"

@interface SPConfigureTriggersCell : SPCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *arrowIamgeView;
@property (weak, nonatomic) IBOutlet UILabel *lineLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;
@property (nonatomic,strong) SPConfigureZoneModel* model;


@end
