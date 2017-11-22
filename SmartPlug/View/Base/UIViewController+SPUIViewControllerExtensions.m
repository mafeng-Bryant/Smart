//
//  UIViewController+SPUIViewControllerExtensions.m
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "UIViewController+SPUIViewControllerExtensions.h"
#import "UIView+Extensions.h"


@implementation UIViewController (SPUIViewControllerExtensions)

- (void)setLeftItemImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *leftBtn = [UIButton createButton:CGRectMake(0,0,44,44) action:@selector(leftItemClickAction:) delegate:self normalImage:image highlightedImage:image];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

-(void)leftItemClickAction:(UIButton *)btn
{
    
}

- (void)setRightItemImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *rightBtn = [UIButton createButton:CGRectMake(0,0,44,44) action:@selector(rightItemClickAction:) delegate:self normalImage:image highlightedImage:image];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

-(void)rightItemClickAction:(UIButton *)btn
{
    
}

-(void)setTitle:(NSString *)title backButton:(BOOL)showBackButton
{
    self.navigationItem.backBarButtonItem = nil;
    if (showBackButton){
        self.navigationItem.leftBarButtonItem.title = @"";
        UIButton *leftBtn = [UIButton createButton:CGRectMake(0,0,44,44) action:@selector(back:) delegate:self normalImage:nil highlightedImage:nil];
        [leftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
    }else{
        self.navigationItem.hidesBackButton = YES;
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    }
    
    //Create title label
    if (title && [title isKindOfClass:[NSString class]] && [title length]>0){
        UILabel *titleLbl = [UILabel createLable:CGRectMake(0, 0, 190, 44)];
        [titleLbl setTextAlignment:NSTextAlignmentCenter];
        titleLbl.textColor = [UIColor blackColor];
        titleLbl.text = title;
        titleLbl.font= [UIFont systemFontOfSize:14];
        titleLbl.backgroundColor = [UIColor clearColor];
        self.navigationItem.titleView = titleLbl;
    }
}

- (void)setTitleView:(NSString *)title
{
    UILabel *titleLbl = [UILabel createLable:CGRectMake(0, 0, 190, 44)];
    [titleLbl setTextAlignment:NSTextAlignmentCenter];
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.text = title;
    titleLbl.font= [UIFont systemFontOfSize:14];
    titleLbl.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleLbl;
}

-(void)back:(UIButton *)btn
{
    btn.userInteractionEnabled = NO;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
