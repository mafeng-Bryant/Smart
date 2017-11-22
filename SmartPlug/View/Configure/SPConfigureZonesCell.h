//
//  SPConfigureZonesCell.h
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCell.h"
#import "SPConfigureZoneModel.h"

@interface SPConfigureZonesCell : SPCell
@property (weak, nonatomic) IBOutlet UILabel *zoneNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *roomLbl;
@property (weak, nonatomic) IBOutlet UILabel *lineLbl;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (nonatomic,strong) SPConfigureZoneModel* model;

- (void)configureData:(SPConfigureZoneModel*)model;

@end
