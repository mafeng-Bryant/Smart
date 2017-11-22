//
//  SPBaseController.h
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SPUIViewControllerExtensions.h"

@protocol UniversalDelegate <NSObject>
@optional
- (void)callBack:(id)info;
- (void)callBack:(id)info withObject:(id)info1;
- (void)callBack:(id)info withObject:(id)info1 withObject:(id)info2;
@end

@interface SPBaseController : UIViewController
{
    __unsafe_unretained id<UniversalDelegate>universalDelegate;
}
@property (nonatomic,assign)id<UniversalDelegate>universalDelegate;
@property (nonatomic,assign)BOOL isPushBySideViewController;
- (void)configureViews;
- (void)testAmbiguity; //测试view的约束是否充分,only work DEBUG mode,
- (void)viewWillDisappearByGestureRecognizer; //side view controller
- (void)sideViewControllerGesturePopViewController;
- (void)reloadViews;
+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;




@end
