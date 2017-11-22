//
//  SPSceneSetCell.h
//  SmartPlug
//
//  Created by patpat on 2017/11/10.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCell.h"

@interface SPSceneSetCell : SPCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *stateLbl;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

@end
