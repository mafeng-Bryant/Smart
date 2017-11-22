//
//  SPAboutUSController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPAboutUSController.h"
#import "SPTitleView.h"
#import "Help.h"

@interface SPAboutUSController ()

@end

@implementation SPAboutUSController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[SPTitleView alloc]initWithFrame:CGRectZero title:@"关于我们"];
    [self setLeftItem];
}

- (void)setLeftItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 24, 24);
    [btn addTarget:self action:@selector(closeAction:)
  forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)closeAction:(UIButton*)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
