//
//  SPDatePicker_DateModel.h
//  SmartPlug
//
//  Created by patpat on 2017/11/16.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPDatePicker_DateModel : NSObject

@property (nonatomic, retain) NSString *year;
@property (nonatomic, retain) NSString *month;
@property (nonatomic, retain) NSString *day;
@property (nonatomic, retain) NSString *hour;
@property (nonatomic, retain) NSString *minute;

- (id)initWithDate:(NSDate *)date;

@end
