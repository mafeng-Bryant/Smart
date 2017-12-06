//
//  PPHUDView.m
//  PatPat
//
//  Created by Yuan on 15/1/12.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPHUDView.h"
#import "Help.h"

#define kPPHUDViewAnimationTime 1.6
#define PPHUDViewColor RGB(68,68,68,0.9)


@interface PPHUDView()

-  (void)setImage:(NSString *)imageName
             text:(NSString *)text;

@end

@implementation PPHUDView

- (NSTimeInterval)delayTime:(NSString *)string
{
    if (isValidString(string) && string.length>25) { //大于25个字就返回2.5s
        return 2.0;
    }else if(isValidString(string) && string.length>40) { //大于40个字就返回2.6s
        return 2.6;
    }
    return kPPHUDViewAnimationTime;
}

-  (void)setImage:(NSString *)imageName
             text:(NSString *)text
            delay:(CGFloat)time
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:Image(imageName)];
    self.customView = imageView;
    self.mode = MBProgressHUDModeCustomView;
    self.labelFont = [UIFont systemFontOfSize:14];
    self.detailsLabelFont =[UIFont systemFontOfSize:14];
    self.detailsLabelText = text;
    self.color = PPHUDViewColor;
    [self hide:YES afterDelay:time];
}


- (void)setImage:(NSString *)imageName view:(UIView*)view
{
    UIImageView* imageView = [[UIImageView alloc] initWithImage:Image(imageName)];
    self.color =  [UIColor lightGrayColor];
    self.customView = imageView;
    self.labelText = @"";
    self.mode = MBProgressHUDModeCustomView;
    self.frame= CGRectMake(0, 0, 90, 90);
    self.center = view.center;
    self.alpha = 0.9;
    [self hide:YES afterDelay:5.0];
}

-  (void)setImage:(NSString *)imageName
             text:(NSString *)text
           detail:(NSString *)detail
            delay:(CGFloat)time
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:Image(imageName)];
    self.customView = imageView;
    self.mode = MBProgressHUDModeCustomView;
    self.labelText = text;
    self.labelFont = [UIFont systemFontOfSize:14];;
    self.detailsLabelFont = [UIFont systemFontOfSize:14];;
    self.color = PPHUDViewColor;
    self.detailsLabelText = detail;
    [self hide:YES afterDelay:time];
}

-  (void)setImage:(NSString *)imageName
             text:(NSString *)text
{
    [self setImage:imageName text:text delay:[self delayTime:text]];
}

-  (void)showSuccessedLabelText:(NSString *)text
{
    [self setImage:@"hub_success" text:text];
}

-  (void)showFailurLabelText:(NSString *)text
{
    [self setImage:@"hub_error" text:text];
}

-  (void)showFailurLabelText:(NSString *)text dismiss:(NSTimeInterval)delay
{
   [self setImage:@"hub_error" text:text delay:delay];
}

-  (void)showFailurLabelText:(NSString *)text
                      detail:(NSString *)detail
{
    [self setImage:@"hub_error" text:text detail:detail delay:[self delayTime:detail]];
}

- (void)showTips:(NSString*)tips image:(NSString*)imageName
{
    [self setImage:imageName text:tips];
}

+ (void)showTitle:(NSString *)title
           detail:(NSString *)detail
{
    PPHUDView *hub = [PPHUDView showTo:[[UIApplication sharedApplication].windows lastObject]];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = title;
    hub.color = PPHUDViewColor;
    hub.detailsLabelText = detail;
    hub.labelFont = [UIFont systemFontOfSize:14];
    hub.detailsLabelFont = [UIFont systemFontOfSize:14];
    hub.removeFromSuperViewOnHide = YES;
    [hub hide:YES afterDelay:[hub delayTime:detail]];
}

+ (void)showErrorDetailMessage:(NSString *)message
{
    [self showTitle:@"opos!" detail:message];
}

+ (void)showTips:(NSString*)message image:(NSString*)imageName showToView:(UIView*)view
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:Image(imageName)];
    PPHUDView *hub = [PPHUDView showTo:view];
    hub.mode = MBProgressHUDModeCustomView;
    hub.customView = imageView;
    hub.color = PPHUDViewColor;
    hub.detailsLabelText = message;
    hub.detailsLabelFont = [UIFont systemFontOfSize:14];
    hub.detailsLabelColor = PPC7;
    hub.removeFromSuperViewOnHide = YES;    
    [hub hide:YES afterDelay:[hub delayTime:message]];
}

+ (void)showNormalDetailMessage:(NSString *)message
{
    [self showTitle:nil detail:message];
}

+ (PPHUDView *)showToWindow
{
    PPHUDView *hub = [PPHUDView showTo:[UIApplication sharedApplication].keyWindow];
    return hub;
}

+ (PPHUDView *)showTo:(UIView *)view
{
    PPHUDView *hub = [PPHUDView showHUDAddedTo:view animated:YES];
    hub.color = PPHUDViewColor;
    return hub;
}

+ (PPHUDView *)showLoadingTo:(UIView *)view
{
   return [self showTo:view text:@"Loading"];
}

+ (PPHUDView *)showTo:(UIView *)view text:(NSString *)text
{
    PPHUDView *hub = [PPHUDView showHUDAddedTo:view animated:YES];
    hub.labelText = text;
    hub.labelFont = [UIFont systemFontOfSize:14];
    hub.color = PPHUDViewColor;
    return hub;
}

- (void)hide
{
    [self hide:YES];
}

- (void)setErrorTitle:(NSString *)title
               detail:(NSString *)detail
{
    [self setTitle:title detail:detail];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:Image(@"hub_error")];
    self.labelFont = [UIFont systemFontOfSize:14];
    self.detailsLabelFont = [UIFont systemFontOfSize:14];
    self.customView = imageView;
    self.color = PPHUDViewColor;
    self.mode = MBProgressHUDModeCustomView;
}

- (void)setTitle:(NSString *)title
          detail:(NSString *)detail
{
    self.labelText = title;
    self.detailsLabelText = detail;
    self.removeFromSuperViewOnHide = YES;
    self.color =PPHUDViewColor;
    self.labelFont = [UIFont systemFontOfSize:14];
    self.detailsLabelFont = [UIFont systemFontOfSize:14];
}

- (void)showError:(NSError *)error
{
    NSString *txt = error?error.localizedDescription:@"";
    [self showError:error afterDelay:[self delayTime:txt]];
}

- (void)showError:(NSError *)error dismiss:(NSTimeInterval)delay
{
    [self showError:error afterDelay:delay];
}

- (void)showError:(NSError *)error afterDelay:(NSTimeInterval)delay
{
    self.color = PPHUDViewColor;
    self.labelFont = [UIFont systemFontOfSize:14];
    self.detailsLabelFont = [UIFont systemFontOfSize:14];
    [self hide:YES afterDelay:delay];
}

+ (PPHUDView *)hubView:(UIView *)inView
           titleString:(NSString *)title
          detailString:(NSString *)detail
{
    return [self hubView:inView titleString:title detailString:detail];
}

+ (PPHUDView *)hubView:(UIView *)inView
           titleString:(NSString *)title
          detailString:(NSString *)detail
             delayTime:(CGFloat)delayTime
{
    PPHUDView *hub = [PPHUDView showHUDAddedTo:inView animated:YES];
    hub.detailsLabelText = detail;
    hub.labelFont = [UIFont systemFontOfSize:14];;
    hub.detailsLabelFont = [UIFont systemFontOfSize:14];;
    hub.removeFromSuperViewOnHide = YES;
    hub.color = PPHUDViewColor;
    [hub setImage:@"hub_error" text:title delay:delayTime];
    return hub;
}

//标题，文字和提示时间
+ (void)hubText:(NSString *)text
      withTitle:(NSString *)title
       withTime:(int)time
       withView:(UIView *)view{
    PPHUDView *hub = [PPHUDView showHUDAddedTo:view animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = text;
    hub.detailsLabelText = title;
    hub.labelFont = [UIFont systemFontOfSize:14];
    hub.detailsLabelFont = [UIFont systemFontOfSize:14];
    hub.removeFromSuperViewOnHide = YES;
    hub.color = PPHUDViewColor;
    [hub hide:YES afterDelay:time];
}


@end


































