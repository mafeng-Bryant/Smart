//
//  SPAboutController.h
//  SmartPlug
//
//  Created by patpat on 2017/11/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPBaseController.h"

@interface SPAboutController : SPBaseController
@property (weak, nonatomic) IBOutlet UIButton *helpView;
@property (weak, nonatomic) IBOutlet UIButton *warningView;
@property (weak, nonatomic) IBOutlet UIButton *aboutUsView;
@property (weak, nonatomic) IBOutlet UIButton *versionView;
@property (weak, nonatomic) IBOutlet UILabel *helpLbl;
@property (weak, nonatomic) IBOutlet UILabel *warningLbl;
@property (weak, nonatomic) IBOutlet UILabel *aboutusLbl;
@property (weak, nonatomic) IBOutlet UILabel *versionLbl;



- (IBAction)helpAction:(id)sender;
- (IBAction)warningAction:(id)sender;
- (IBAction)aboutUsAction:(id)sender;
- (IBAction)versionAction:(id)sender;

@end
