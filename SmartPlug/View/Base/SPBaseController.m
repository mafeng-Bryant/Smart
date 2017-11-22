//
//  SPBaseController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPBaseController.h"
#import "AppDelegate.h"

@interface SPBaseController ()

@end

@implementation SPBaseController
@synthesize universalDelegate;

- (void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureViews];
}

-(void)back:(UIButton *)btn
{
    [super back:btn];
}

- (void)reloadViews
{
    
}

- (void)viewWillDisappearByGestureRecognizer
{
}

- (void)sideViewControllerGesturePopViewController
{
    //    [[AppDelegate appDelegate].sideContentController popViewController];
}

- (void)testAmbiguity
{
#ifdef DEBUG

#endif
}

#pragma mark - 换肤

- (void)configureViews
{
    //做换肤控制
}

#pragma mark 关于旋屏

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController
{    return (viewController.isViewLoaded && viewController.view.window);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
