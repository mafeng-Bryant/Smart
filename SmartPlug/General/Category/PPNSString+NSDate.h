//
//  PPNSString+Extensions.h
//  PatPat
//
//  Created by Yuan on 15/2/5.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Extensions.h"

typedef void (^SPCountingBlock)(NSInteger days, NSInteger hours,NSInteger minutes,NSInteger seconds);

@interface NSString(NSString_NSDate)

/**
 *  根据minutes计算时间，现实剩余d,h,m
 *
 *  @param minutes 总分钟数
 *
 *  @return NSString
 */
+ (NSString *)leftTime:(NSTimeInterval)minutes;


/**
 *  根据minutes计算时间，现实剩余days,hours,mintues
 *
 *  @param minutes 总分钟数
 *
 *  @return NSString
 */
+ (NSString *)fullUnitleftTime:(NSTimeInterval)minutes;

//计算compareDate时间和现在相差多久,精确到天
+ (NSString *)timeAgoWithDate:(NSDate *)date;


//计算compareDate时间和现在相差多久,精确到分钟
+ (NSString*)timeAgoWithMinuteDate:(NSDate*)date;


/**
 *  设置日期的格式
 *
 *  @param confromTime NSDate
 *  @param dateStyle   样式
 *
 *  @return NSString
 */
+ (NSString *)formatDate:(NSDate *)confromTime dateStyle:(NSString *)dateStyle;

//获取当前时间与某一个时间的时间戳
+ (NSTimeInterval)getTimeSp:(NSString*)dateString;

+ (NSTimeInterval)getTimeInterval:(NSString*)startDateString endDateString:(NSString*)endDateString;

+ (NSString*)getLeftTime:(NSString*)dateString currentDateString:(NSString*)currentDateString;

//hour
+ (NSString*)getStartMinutes:(NSString*)dateString;

//确定是否显示倒计时
+ (BOOL)getTimerInfo:(NSString*)dateString;

+ (BOOL)isShowTime:(NSString*)nowDateString endDateString:(NSString*)endDateString;

//是否倒计时已经结束
+ (BOOL)isNeedReloadData:(NSString*)dateString;

+ (BOOL)isNeedReloadData:(NSString *)dateString currentDateString:(NSString*)currentDateString;

+ (void)getDayHourMinuteSeconds:(NSInteger)time callBack:(SPCountingBlock)block;

+ (NSString*)getRunningTime:(NSInteger)day  hour:(NSInteger)hour minutes:(NSInteger)minutes seconds:(NSInteger)seconds;



@end



