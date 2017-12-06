//
//  PPHUDView.h
//  PatPat
//
//  Created by Yuan on 15/1/12.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "PPLoadingView.h"

@interface PPHUDView : MBProgressHUD

-  (void)showSuccessedLabelText:(NSString *)text;

-  (void)showFailurLabelText:(NSString *)text;

-  (void)showFailurLabelText:(NSString *)text dismiss:(NSTimeInterval)delay;

-  (void)showFailurLabelText:(NSString *)text
                      detail:(NSString *)detail;

+ (void)showNormalDetailMessage:(NSString *)message;

+ (void)showErrorDetailMessage:(NSString *)message;

+ (void)showTips:(NSString*)message image:(NSString*)imageName showToView:(UIView*)view;

+ (void)showTitle:(NSString *)title
           detail:(NSString *)detail;

+ (PPHUDView *)showToWindow;

+ (PPHUDView *)showTo:(UIView *)view;

+ (PPHUDView *)showLoadingTo:(UIView *)view;

+ (PPHUDView *)showTo:(UIView *)view text:(NSString *)text;

- (void)showTips:(NSString*)tips image:(NSString*)imageName;

- (void)hide;

- (void)setTitle:(NSString *)title
          detail:(NSString *)detail;

- (void)setErrorTitle:(NSString *)title
               detail:(NSString *)detail;

- (void)showError:(NSError *)error;

- (void)showError:(NSError *)error dismiss:(NSTimeInterval)delay;

- (void)showError:(NSError *)error afterDelay:(NSTimeInterval)delay;

+ (void)hubText:(NSString *)text withTitle:(NSString *)title withTime:(int)time withView:(UIView *)view;

+ (PPHUDView *)hubView:(UIView *)inView
           titleString:(NSString *)title
          detailString:(NSString *)detail
             delayTime:(CGFloat)delayTime;

+ (PPHUDView *)hubView:(UIView *)inView
           titleString:(NSString *)title
          detailString:(NSString *)detail;




@end
