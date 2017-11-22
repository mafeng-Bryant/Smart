//
//  AppDelegate.h
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseNavigationController.h"
#import "SPHomeController.h"
#import "SPAccessoryController.h"
#import "SPAboutController.h"
#import "SPConfigureController.h"
#import "SPScenesController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) SPHomeController *homeController;
@property (strong, nonatomic) SPAccessoryController *accessoryController;
@property (strong, nonatomic) SPAboutController *aboutController;
@property (strong, nonatomic) SPConfigureController *configreCartController;
@property (strong, nonatomic) SPScenesController *scenesController;

+(AppDelegate *)appDelegate;
+ (void)dismiss;
+ (void)currentNavPushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

