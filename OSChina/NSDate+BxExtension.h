//
//  NSDate+BxExtension.h
//  OSChina
//
//  Created by baxiang on 14-2-11.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BxExtension)

+ (NSDate *)normalFormatDateFromString:(NSString *)string;
- (NSString *)formatWithString:(NSString *)format;
- (NSString *)formatWithStyle:(NSDateFormatterStyle)style;
- (NSString *)intervalSinceNow;

@end
