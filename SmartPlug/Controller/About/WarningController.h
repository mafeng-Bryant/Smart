//
//  WarningController.h
//  SmartPlug
//
//  Created by patpat on 2017/11/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPBaseController.h"

@interface WarningController : SPBaseController
@property (weak, nonatomic) IBOutlet UIImageView *warningImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UILabel *tipsOneLbl;
@property (weak, nonatomic) IBOutlet UILabel *tipsTwoLbl;



@end
