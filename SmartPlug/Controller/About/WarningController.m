//
//  WarningController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import "WarningController.h"
#import "SPTitleView.h"
#import "Help.h"

@interface WarningController ()

@end

@implementation WarningController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[SPTitleView alloc]initWithFrame:CGRectZero title:@"警告"];
    [self setLeftItem];
    _btn1.backgroundColor = [UIColor blackColor];
    ViewRadius(_btn1, 5);
    _btn2.backgroundColor = [UIColor blackColor];
    [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ViewRadius(_btn2, 5);
    _nameLbl.textColor = RGB(205,210,211,1.0);
    _tipsOneLbl.textColor = RGB(205,210,211,1.0);
    _tipsTwoLbl.textColor = RGB(205,210,211,1.0);
    _btn1.enabled = _btn2.enabled = NO;
}

- (void)setLeftItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 24, 24);
    [btn addTarget:self action:@selector(closeAction:)
   forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:14];
   // [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
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
