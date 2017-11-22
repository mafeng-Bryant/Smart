//
//  SPHelper.m
//  SmartPlug
//
//  Created by patpat on 2017/11/22.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPStoreHelper.h"
#import "SFHFKeychainUtils.h"
#import "Help.h"

static NSString * const kServiceDomain                     = @"com.opso";

@implementation SPStoreHelper

+(void)storeValue:(id)value forKey:(NSString *)key
{
    key = [kAppBundleIdentifier stringByAppendingFormat:@".%@",key];
    NSUserDefaults *defaultsSetting = [NSUserDefaults standardUserDefaults];
    if (value==nil) {
        [defaultsSetting removeObjectForKey:key];
    }else{
        [defaultsSetting setValue:value forKey:key];
    }
    [defaultsSetting synchronize];
}

+(id)getValueForKey:(NSString *)key
{
    if (key == nil)return nil;
    key = [kAppBundleIdentifier stringByAppendingFormat:@".%@",key];
    NSUserDefaults *defaultsSetting = [NSUserDefaults standardUserDefaults];
    return [defaultsSetting valueForKey:key];
}

+(void)systemStoreValue:(NSString *)value
                 forKey:(NSString *)key
{
    if (!isValidString(value)) {
        if ([SFHFKeychainUtils deleteItemForUsername:key andServiceName:kServiceDomain error:nil]){
            //            HYLog(@"删除kechain信息成功！");
        }else{
            //            HYLog(@"删除kechain信息失败！");
        }
    }else{
        if ([SFHFKeychainUtils storeUsername:key
                                 andPassword:value
                              forServiceName:kServiceDomain
                              updateExisting:true
                                       error:nil]){
            //            HYLog(@"保存信息到kechain成功！");
        }else{
            //            HYLog(@"保存信息到kechain失败！");
        };
    }
}

+ (id)getSystemValueForKey:(NSString *)key
{
    return [SFHFKeychainUtils getPasswordForUsername:key
                                      andServiceName:kServiceDomain
                                               error:nil];
}

@end
