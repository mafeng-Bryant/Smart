//
//  SPAboutController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPAboutController.h"
#import "SPTitleView.h"
#import "WarningController.h"
#import "SPBaseNavigationController.h"
#import "SPAboutUSController.h"
#import "SPVersionController.h"
#import "SPHelpController.h"
#import "Help.h"

@interface SPAboutController ()

@end

@implementation SPAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[SPTitleView alloc]initWithFrame:CGRectZero title:@"关于"];
    self.helpView.backgroundColor = RGB(43, 228, 79,1.0);
    self.warningView.backgroundColor = RGB(44, 154, 165,1.0);
    self.aboutUsView.backgroundColor = RGB(172, 25, 66,1.0);
    self.versionView.backgroundColor = RGB(95, 83, 182,1.0);
    [self.helpView setImage:Image(@"issue") forState:UIControlStateNormal];
    [self.warningView setImage:Image(@"warningabout") forState:UIControlStateNormal];
    [self.aboutUsView setImage:Image(@"aboutus") forState:UIControlStateNormal];
    [self.versionView setImage:Image(@"warningissue") forState:UIControlStateNormal];
    self.helpLbl.textColor = [UIColor whiteColor];
    self.warningLbl.textColor = [UIColor whiteColor];
    self.aboutusLbl.textColor = [UIColor whiteColor];
    self.versionLbl.textColor = [UIColor whiteColor];
    
}

- (IBAction)helpAction:(id)sender
{
    SPHelpController* wc = [[SPHelpController alloc]initWithNibName:@"SPHelpController" bundle:nil];
    SPBaseNavigationController* na = [[SPBaseNavigationController alloc]initWithRootViewController:wc];
    [self presentViewController:na animated:YES completion:nil];
}

- (IBAction)warningAction:(id)sender
{
    WarningController* wc = [[WarningController alloc]initWithNibName:@"WarningController" bundle:nil];
    SPBaseNavigationController* na = [[SPBaseNavigationController alloc]initWithRootViewController:wc];
    [self presentViewController:na animated:YES completion:nil];
}

- (IBAction)aboutUsAction:(id)sender
{
    SPAboutUSController* wc = [[SPAboutUSController alloc]initWithNibName:@"SPAboutUSController" bundle:nil];
    SPBaseNavigationController* na = [[SPBaseNavigationController alloc]initWithRootViewController:wc];
    [self presentViewController:na animated:YES completion:nil];
}

- (IBAction)versionAction:(id)sender
{
    SPVersionController* wc = [[SPVersionController alloc]initWithNibName:@"SPVersionController" bundle:nil];
    SPBaseNavigationController* na = [[SPBaseNavigationController alloc]initWithRootViewController:wc];
    [self presentViewController:na animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
