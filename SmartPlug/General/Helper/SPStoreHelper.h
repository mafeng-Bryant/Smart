//
//  SPHelper.h
//  SmartPlug
//
//  Created by patpat on 2017/11/22.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kNewUserKey                        = @"com.opso.newUserKey";

@interface SPStoreHelper : NSObject
//存储到NSUserDefaults
+ (void)storeValue:(id)value forKey:(NSString *)key;

//根据key从NSUserDefaults获取值
+ (id)getValueForKey:(NSString *)key;

//存储到系统的钥匙串
+(void)systemStoreValue:(NSString *)value
                 forKey:(NSString *)key;

//根据key从系统的钥匙串获取值
+ (id)getSystemValueForKey:(NSString *)key;

@end
