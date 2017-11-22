//
//  SPBaseNavigationController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPBaseNavigationController.h"
#import "Help.h"

@interface SPBaseNavigationController()<UIGestureRecognizerDelegate>

@end

@implementation SPBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置Nav背景色
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationBar setTranslucent:NO];
    [[UINavigationBar appearance] setBackgroundImage: [UIImage imageNamed:@"navbackground.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [self imageWithColor:RGB(228, 232, 230, 1.0) size:CGSizeMake(0.5,0.5)];
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
