//
//  SPHelpHeaderView.h
//  SmartPlug
//
//  Created by patpat on 2017/11/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPHelpHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *helpImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (nonatomic,assign) NSInteger section;

+ (SPHelpHeaderView *)instanceHeadView;

@end
