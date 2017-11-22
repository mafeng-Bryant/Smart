//
//  UIViewController+SPUIViewControllerExtensions.h
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SPUIViewControllerExtensions)

- (void)setLeftItemImage:(NSString *)imageName;

-(void)leftItemClickAction:(UIButton *)btn;

- (void)setRightItemImage:(NSString *)imageName;

-(void)rightItemClickAction:(UIButton *)btn;

-(void)setTitle:(NSString *)title backButton:(BOOL)showBackButton;

- (void)setTitleView:(NSString *)title;

-(void)back:(UIButton *)btn;

@end
