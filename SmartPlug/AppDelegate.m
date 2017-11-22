//
//  AppDelegate.m
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "AppDelegate.h"
#import "SPSetting.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    _homeController = [[SPHomeController alloc]initWithNibName:@"SPHomeController" bundle:nil];
    SPBaseNavigationController *featureNav = [[SPBaseNavigationController alloc]initWithRootViewController:_homeController];
    UITabBarItem *tabItem = [[UITabBarItem alloc]initWithTitle:@"主页" image:nil selectedImage:nil];
    featureNav.tabBarItem = tabItem;
    
    _accessoryController = [[SPAccessoryController alloc]initWithNibName:@"SPAccessoryController" bundle:nil];
    SPBaseNavigationController *categoryNav = [[SPBaseNavigationController alloc]initWithRootViewController:_accessoryController];
    tabItem = [[UITabBarItem alloc]initWithTitle:@"设备" image:nil selectedImage:nil];
    categoryNav.tabBarItem = tabItem;
    
    _scenesController = [[SPScenesController alloc]initWithNibName:@"SPScenesController" bundle:nil];
    SPBaseNavigationController *lifeNav = [[SPBaseNavigationController alloc]initWithRootViewController:_scenesController];
    tabItem = [[UITabBarItem alloc]initWithTitle:@"场景" image:nil selectedImage:nil];
    lifeNav.tabBarItem = tabItem;
    
   _configreCartController = [[SPConfigureController alloc] initWithNibName:@"SPConfigureController" bundle:nil];
    SPBaseNavigationController *accountNav = [[SPBaseNavigationController alloc]initWithRootViewController:_configreCartController];
    tabItem = [[UITabBarItem alloc]initWithTitle:@"配置" image:nil selectedImage:nil];
    accountNav.tabBarItem = tabItem;
    
    _aboutController = [[SPAboutController alloc] initWithNibName:@"SPAboutController" bundle:nil];
    SPBaseNavigationController *cartNav = [[SPBaseNavigationController alloc]initWithRootViewController:_aboutController];
    tabItem = [[UITabBarItem alloc]initWithTitle:@"关于" image:nil selectedImage:nil];
    cartNav.tabBarItem = tabItem;
    
    _tabBarController = [[UITabBarController alloc]init];
    [_tabBarController.tabBar setTintColor:[UIColor redColor]];
    _tabBarController.delegate = self;
    _tabBarController.tabBar.layer.borderWidth = 0.25;
    _tabBarController.tabBar.layer.borderColor = [UIColor blackColor].CGColor;
    [_tabBarController.tabBar setClipsToBounds:YES];
    
    [_tabBarController setViewControllers:@[featureNav,categoryNav,lifeNav,accountNav,cartNav] animated:NO];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    if (self.window) {
        [self.window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.window.rootViewController = nil;
        [self.window removeFromSuperview];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = _tabBarController;
    [self.window makeKeyAndVisible];
    [[SPSetting sharedSPSetting].popUpControllerManager showIntroduceSlides];//显示引导页
    return YES;
}

+(AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (void)dismiss
{
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

+ (void)currentNavPushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UINavigationController *nav = [AppDelegate appDelegate].tabBarController.selectedViewController;
    [nav pushViewController:viewController animated:animated];
}


#pragma mark UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(SPBaseNavigationController *)viewController
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
