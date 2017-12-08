//
//  SPPopUpView.h
//  SmartPlug
//
//  Created by patpat on 2017/12/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SPPopUpViewStyleBlock)(NSUInteger clickIndex);

@interface SPPopUpView : UIView
{
    UILabel *_titleLbl;
    UILabel *_lineLbl;
    UILabel *_btnLineLel;
    SPPopUpViewStyleBlock _clickBlock;
    UIButton* _cancelBtn;
    UIButton *_okBtn;
    UILabel* _messageLbl;
}

+ (void)showAlertStyleWithOkButtonTitle:(NSString *)okButtonTitle
                    cancelButtonTitle:(NSString *)cancelButtonTitle
                       clickBlock:(SPPopUpViewStyleBlock)block;

//升级固件
+ (void)showAlertStyleWithTitle:(NSString*)title
                        message:(NSString*)message
                  okButtonTitle:(NSString *)okButtonTitle
              cancelButtonTitle:(NSString *)cancelButtonTitle
                     clickBlock:(SPPopUpViewStyleBlock)block;


@end
