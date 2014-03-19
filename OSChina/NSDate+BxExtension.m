//
//  NSDate+BxExtension.m
//  OSChina
//
//  Created by baxiang on 14-2-11.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "NSDate+BxExtension.h"

#define TT_MINUTE 60
#define TT_HOUR   (60 * TT_MINUTE)
#define TT_DAY    (24 * TT_HOUR)
#define TT_5_DAYS (5 * TT_DAY)
#define TT_WEEK   (7 * TT_DAY)
#define TT_MONTH  (30.5 * TT_DAY)
#define TT_YEAR   (365 * TT_DAY)

@implementation NSDate (BxExtension)


+ (NSDate *)normalFormatDateFromString:(NSString *)string {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:string];
}

- (NSString *)formatWithString:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *string = [formatter stringFromDate:self];
    return string;
}

- (NSString *)formatWithStyle:(NSDateFormatterStyle)style {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:style];
    NSString *string = [formatter stringFromDate:self];
    return string;
}
- (NSString *)intervalSinceNow  {
        NSTimeInterval elapsed = [self timeIntervalSinceNow];
        if (elapsed > 0) {
            if (elapsed <= 1) {
                return [NSString stringWithFormat:@"刚刚"];
            }
            else if (elapsed < TT_MINUTE) {
                int seconds = (int)(elapsed);
                return [NSString stringWithFormat:@"%d秒前", seconds];
            }
            else if (elapsed < TT_HOUR) {
                int mins = (int)(elapsed/TT_MINUTE);
                return [NSString stringWithFormat:@"%d分钟前", mins];
            }
            else if (elapsed < TT_DAY) {
                int hours = (int)(elapsed/TT_HOUR);
                return [NSString stringWithFormat:@"%d小时前", hours];
            }
            else {
                int days = (int)(elapsed/TT_DAY);
                return [NSString stringWithFormat:@"%d天前", days];
            }
        }
        else {
            elapsed = -elapsed;
            if (elapsed <= 1) {
                return [NSString stringWithFormat:@"刚刚"];
            }
            else if (elapsed < TT_MINUTE) {
                int seconds = (int)(elapsed);
                return [NSString stringWithFormat:@"%d秒前", seconds];
            }
            
             else if (elapsed < TT_HOUR) {
                int mins = (int)(elapsed/TT_MINUTE);
                return [NSString stringWithFormat:@"%d分钟前", mins];
                
            }  else if (elapsed < TT_DAY) {
                int hours = (int)(elapsed/TT_HOUR);
                return [NSString stringWithFormat:@"%d小时前", hours];
                
            } else {
                int days = (int)(elapsed/TT_DAY);
                return [NSString stringWithFormat:@"%d天前", days];
            }
        }
}
@end
