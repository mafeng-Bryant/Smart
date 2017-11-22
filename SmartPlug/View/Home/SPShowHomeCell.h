//
//  SPShowHomeCell.h
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCell.h"
#import "SPHomeModel.h"

@interface SPShowHomeCell : SPCell
@property (weak, nonatomic) IBOutlet UILabel *homeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (nonatomic,strong) SPHomeModel* model;


@end
