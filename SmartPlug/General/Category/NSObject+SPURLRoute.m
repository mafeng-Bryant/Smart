//
//  NSObject+SPURLRoute.m
//  SmartPlug
//
//  Created by patpat on 2017/11/22.
//  Copyright © 2017年 test. All rights reserved.
//

#import "NSObject+SPURLRoute.h"

@implementation NSObject (SPURLRoute)

- (UIViewController *)currentVisibleViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (UIViewController *)rootViewController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

@end

