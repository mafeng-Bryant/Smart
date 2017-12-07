//
//  PPNSString+Extensions.m
//  PatPat
//
//  Created by Yuan on 15/2/5.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPNSString+NSDate.h"
#import "Help.h"

@implementation NSString(NSString_NSDate)

+ (NSString *)leftTime:(NSTimeInterval)minutes
{
    NSTimeInterval onehour = 60; //1h=60m
    NSTimeInterval oneday = 1440;//1d=1440m
    if (minutes<onehour) {
        return [NSString stringWithFormat:@"%ldm",lrint(minutes)];
    }else if (minutes<oneday) {
        NSString *string = [NSString stringWithFormat:@"%.1fh",rintf(minutes/onehour)];
        return [string stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else {
        return [NSString stringWithFormat:@"%ldd",lrint(floor(minutes/oneday))];
    }
}

+ (NSString *)fullUnitleftTime:(NSTimeInterval)minutes
{
    NSTimeInterval oneMinutes = 1;
    NSTimeInterval onehour = 60; //1h=60m
    NSTimeInterval oneday = 1440;//1d=1440m
    if (minutes<oneMinutes) {
        long int intSeconds = ceil(minutes*60);
        NSString *unit = intSeconds>1?@"seconds":@"second";
        return [NSString stringWithFormat:@"%ld %@",intSeconds,unit];
    }else if (minutes<onehour) {
        long int intMinutes= lrint(minutes);
        NSString *unit = intMinutes>1?@"minutes":@"minute";
        return [NSString stringWithFormat:@"%ld %@",intMinutes,unit];
    }else if (minutes<oneday) {
        float floatHous= rintf(minutes/onehour);
        NSString *unit = floatHous>1?@"hours":@"hour";
        NSString *string = [NSString stringWithFormat:@"%.1f %@",floatHous,unit];
        return [string stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else {
        long int intDays= lrint(floor(minutes/oneday));
        NSString *unit = intDays>1?@"days":@"day";
        return [NSString stringWithFormat:@"%ld %@",intDays,unit];
    }
}

+ (NSString *)timeAgoWithDate:(NSDate *)date
{
    if (!date)return @"";
    NSTimeInterval deltaSeconds = fabs([date timeIntervalSinceNow]);
    NSTimeInterval deltaMinutes = deltaSeconds / 60.0f;
    NSInteger minutes;
    if (deltaSeconds<5) {
        return @"Just now";
    }else if(deltaSeconds < 60){
        return [NSString stringWithFormat:@"%.0f seconds ago",ceil(deltaSeconds)];
    }else if(deltaSeconds < 120){
        return @"A minute ago";
    }else if(deltaMinutes < 60){
        return [NSString stringWithFormat:@"%.0f minutes ago",ceil(deltaMinutes)];
    }else if(deltaMinutes < 120){
        return @"An hour ago";
    }else if(deltaMinutes < (24 * 60)){
        minutes = (int)floor(deltaMinutes/60);
        return [NSString stringWithFormat:@"%ld hours ago",(long)minutes];
    }else if(deltaMinutes < (24 * 60 * 2)){
        return @"Yesterday";
    }else {
        return [date formatWithStyle:@"MMM dd, yyyy"];
    }
}

+ (NSString*)timeAgoWithMinuteDate:(NSDate*)date
{
    if (!date)return @"";
    NSTimeInterval deltaSeconds = fabs([date timeIntervalSinceNow]);
    NSTimeInterval deltaMinutes = deltaSeconds / 60.0f;
    NSInteger minutes;
    if (deltaSeconds<5) {
        return @"Just now";
    }else if(deltaSeconds < 60){
        return [NSString stringWithFormat:@"%.0f seconds ago",ceil(deltaSeconds)];
    }else if(deltaSeconds < 120){
        return @"A minute ago";
    }else if(deltaMinutes < 60){
        return [NSString stringWithFormat:@"%.0f minutes ago",ceil(deltaMinutes)];
    }else if(deltaMinutes < 120){
        return @"An hour ago";
    }else if(deltaMinutes < (24 * 60)){
        minutes = (int)floor(deltaMinutes/60);
        return [NSString stringWithFormat:@"%ld hours ago",(long)minutes];
    }else if(deltaMinutes < (24 * 60 * 2)){
        return @"Yesterday";
    }else {
        return [date formatWithStyle:@"MMM dd, yyyy HH:mm"];
    }
}

+ (NSString *)formatDate:(NSDate *)confromTime dateStyle:(NSString *)dateStyle
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateStyle];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTime];
    return confromTimespStr;
}


+ (NSTimeInterval)getTimeSp:(NSString*)dateString
{
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setTimeZone:timeZone];
    NSDate* localDate = [formatter dateFromString:dateString];
    NSTimeInterval end_timesp = [localDate timeIntervalSince1970];
    NSDate *datenow = [NSDate date];
    NSTimeInterval date_timesp = [datenow timeIntervalSince1970];
    return end_timesp - date_timesp;
}

+ (NSTimeInterval)getTimeInterval:(NSString*)startDateString endDateString:(NSString*)endDateString
{
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setTimeZone:timeZone];
    NSDate* endDate = [formatter dateFromString:endDateString];
    NSTimeInterval end_timesp = [endDate timeIntervalSince1970];
    NSDate* startDate = [formatter dateFromString:startDateString];
    NSTimeInterval start_timesp = [startDate timeIntervalSince1970];
    return end_timesp - start_timesp;
}


+ (BOOL)getTimerInfo:(NSString*)dateString
{
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setTimeZone:timeZone];
    NSDate* localDate = [formatter dateFromString:dateString];
    NSTimeInterval end_timesp = [localDate timeIntervalSince1970];
    NSDate *datenow = [NSDate date];
    NSTimeInterval date_timesp = [datenow timeIntervalSince1970];
    NSTimeInterval maxSeconds = 24*60*60;
    int minus = (end_timesp - date_timesp);
    if (minus<=maxSeconds) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL)isShowTime:(NSString*)nowDateString endDateString:(NSString*)endDateString
{
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setTimeZone:timeZone];
    NSDate* localDate = [formatter dateFromString:endDateString];
    NSTimeInterval end_timesp = [localDate timeIntervalSince1970];
    NSDate* startDate = [formatter dateFromString:nowDateString];
    NSTimeInterval start_timesp = [startDate timeIntervalSince1970];
    NSTimeInterval maxSeconds = 24*60*60;
    int minus = (end_timesp - start_timesp);
    if (minus<=maxSeconds) {
        return YES;
    }else {
        return NO;
    }
}

+ (NSString*)getStartMinutes:(NSString*)dateString
{
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setTimeZone:timeZone];
    NSDate* localDate = [formatter dateFromString:dateString];
    return [localDate formatWithStyle:@"HH:mm"];
}

+ (NSString*)getLeftTime:(NSString*)dateString currentDateString:(NSString*)currentDateString
{
    NSTimeInterval end_timesp = [[self getCurrentDateMinutes:dateString] timeIntervalSince1970];
    NSTimeInterval current_end_timesp  = [[self getCurrentDateMinutes:currentDateString] timeIntervalSince1970];
    return [self fullUnitleftTime:(end_timesp-current_end_timesp)/60];
}

//是否倒计时已经结束
+ (BOOL)isNeedReloadData:(NSString*)dateString
{
    NSTimeInterval end_timesp = [[self getCurrentDateMinutes:dateString] timeIntervalSince1970];
    NSTimeInterval current_end_timesp  = [ [NSDate date] timeIntervalSince1970];
    if (end_timesp -current_end_timesp <=0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isNeedReloadData:(NSString *)dateString currentDateString:(NSString*)currentDateString
{
    NSTimeInterval end_timesp = [[self getCurrentDateMinutes:dateString] timeIntervalSince1970];
    NSTimeInterval current_end_timesp = [[self getCurrentDateMinutes:currentDateString] timeIntervalSince1970];
    if (end_timesp -current_end_timesp <=0) {
        return YES;
    }
    return NO;
}

+ (NSDate*)getCurrentDateMinutes:(NSString*)dateString
{
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setTimeZone:timeZone];
    return  [formatter dateFromString:dateString];
}

+ (void)getDayHourMinuteSeconds:(NSInteger)time callBack:(SPCountingBlock)block
{
    if (time > 0) {
        //format of day
        NSString *str_day = [NSString stringWithFormat:@"%02ld",time/(3600*24)];
        NSInteger day = 0;
        NSInteger hour = 0;
        NSInteger minutes = 0;
        NSInteger seconds = 0;
        if (isValidString(str_day)) {
            day = [str_day integerValue]>0?[str_day integerValue]:0;
        }
        
        //format of hour
        NSString *str_hour = [NSString stringWithFormat:@"%02ld",time/3600];
        if (isValidString(str_hour)) {
            hour = [str_hour integerValue];
        }
    
        //format of minute
        NSString *str_minute = [NSString stringWithFormat:@"%02ld",(time%3600)/60];
        if (isValidString(str_minute)) {
            minutes = [str_minute integerValue];
        }
      
        //format of second
        NSString *str_second = [NSString stringWithFormat:@"%02ld",time%60];
        if (isValidString(str_second)) {
            seconds = [str_second integerValue];
        }
        block(day,hour,minutes,seconds);
        return;
    }
    
    block(0,0,0,0);
}

+ (NSString*)getRunningTime:(NSInteger)day  hour:(NSInteger)hour minutes:(NSInteger)minutes seconds:(NSInteger)seconds
{
    NSString* timeDescription = @"0天0小时0分钟0秒";
    NSString* dayString = @"";
    NSString* hourString = @"";
    NSString* minutesString = [NSString stringWithFormat:@"0分钟"];
    NSString* secondsString = [NSString stringWithFormat:@"0秒"];
    if (day>0) {
        dayString = [NSString stringWithFormat:@"%ld天",day];
    }
    if (hour>0) {
        hourString = [NSString stringWithFormat:@"%ld小时",hour];
    }
    if (minutes>0) {
        minutesString = [NSString stringWithFormat:@"%ld分钟",minutes];
    }
    if (seconds>0) {
       secondsString = [NSString stringWithFormat:@"%ld秒",seconds];
    }
    
    if (isValidString(dayString) && isValidString(hourString)) {
        return [NSString stringWithFormat:@"%@%@%@%@",dayString,hourString,minutesString,secondsString];
    }else if (isValidString(dayString) && !isValidString(hourString)){
        hourString = [NSString stringWithFormat:@"0小时"];
        return [NSString stringWithFormat:@"%@%@%@%@",dayString,hourString,minutesString,secondsString];
    }else {
        if (!isValidString(dayString) && isValidString(hourString)) {
            return [NSString stringWithFormat:@"%@%@%@",hourString,minutesString,secondsString];
        }else if (!isValidString(dayString) && !isValidString(hourString)){
            return [NSString stringWithFormat:@"%@%@",minutesString,secondsString];
        }
    }
    return timeDescription;
}

@end




