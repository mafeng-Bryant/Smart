//
//  SPRoomCell.h
//  SmartPlug
//
//  Created by patpat on 2017/11/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCell.h"
#import "SPAccessoryInfo.h"

@interface SPRoomCell : SPCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *roomLbl;
@property (nonatomic,strong) SPAccessoryInfo* info;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;


@end
