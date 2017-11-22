//
//  SPConfigureHeadView.h
//  SmartPlug
//
//  Created by patpat on 2017/11/8.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPConfigureHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *sectionLbl;
@property (weak, nonatomic) IBOutlet UILabel *addLbl;
@property (nonatomic,assign) NSInteger section;

+ (SPConfigureHeadView *)instanceHeadView;




@end
