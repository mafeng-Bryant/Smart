//
//  SPPowerInfoCell.h
//  SmartPlug
//
//  Created by patpat on 2017/12/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPCell.h"
#import "SPPowerTableViewInfo.h"
#import "SPPowerDataSource.h"
#import "Help.h"
#import "UIView+Extensions.h"
#import "SPXValueModel.h"

@interface SPPowerInfoCell : SPCell

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic,strong) UIScrollView* scrollView;

- (void)configureData:(SPPowerTableViewInfo*)info type:(SPPowerDataSourceSegmentType)type costType:(SPXValueModelType)costType;

@end
