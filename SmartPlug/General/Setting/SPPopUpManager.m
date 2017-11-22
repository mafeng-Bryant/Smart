//
//  SPPopUpManager.m
//  SmartPlug
//
//  Created by patpat on 2017/11/22.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPPopUpManager.h"
#import "SPBaseController.h"
#import "SPStoreHelper.h"
#import "SPShowGuideController.h"
#import "NSObject+SPURLRoute.h"

static NSString * const kIsShowGuideSlides    = @"kIsShowGuide";//引导页

@interface SPPopUpManager()<UniversalDelegate>

@end

@implementation SPPopUpManager

- (void)showIntroduceSlides
{
    if ([self isShowGuideSlide]) {
        [self showGuideSlide:NO completion:nil];
    }
}

- (void)showGuideSlide:(BOOL)animated
            completion:(void (^)(void))completion
{
    SPShowGuideController *guideVC = [[SPShowGuideController alloc]init];
    [[self rootViewController] presentViewController:guideVC animated:animated completion:completion];
}


#pragma mark Private

- (void)showedGuideSlide
{
    [self isShowGuideSlide];
}

- (BOOL)isShowGuideSlide
{
    NSString *key = [kIsShowGuideSlides stringByAppendingString:kAppVersion];
    id object = [SPStoreHelper getValueForKey:key];
    if (object)return NO;
    [SPStoreHelper storeValue:@(1) forKey:key];
    return YES;
}


@end
