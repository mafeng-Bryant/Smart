//
//  SPDatePicker.h
//  SmartPlug
//
//  Created by patpat on 2017/11/16.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPDatePicker;

typedef enum{
    SPDateStyle_YearMonthDayHourMinute = 0,
    SPDateStyle_YearMonthDay,
    SPDateStyle_MonthDayHourMinute,
    SPDateStyle_HourMinute
}DateStyle;

typedef void (^FinishBlock)(NSString * year,
                            NSString * month,
                            NSString * day,
                            NSString * hour,
                            NSString * minute,
                            NSString * weekDay);

@protocol SPDatePickerDelegate <NSObject>

- (void)datePicker:(SPDatePicker *)datePicker
                year:(NSString *)year
               month:(NSString *)month
                 day:(NSString *)day
                hour:(NSString *)hour
              minute:(NSString *)minute
             weekDay:(NSString *)weekDay;
@end


@interface SPDatePicker : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, assign) id <SPDatePickerDelegate> delegate;
@property (nonatomic, assign) DateStyle datePickerStyle;
@property (nonatomic, retain) NSDate *ScrollToDate;//滚到指定日期
@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认2049）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认1970）

- (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
- (id)initWithframe:(CGRect)frame Delegate:(id<SPDatePickerDelegate>)delegate PickerStyle:(DateStyle)uuDateStyle;
- (id)initWithframe:(CGRect)frame PickerStyle:(DateStyle)uuDateStyle didSelected:(FinishBlock)finishBlock;


@end
