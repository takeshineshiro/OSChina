//
//  NSDictionary+BxExtension.h
//  OSChina
//
//  Created by baxiang on 14-2-12.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BxExtension)

- (NSString *)stringForKey:(NSString *)key;
- (NSNumber *)numberForKey:(NSString *)key;
- (int)intForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key;
- (NSMutableDictionary *)mutableDictionaryForKey:(NSString *)key;
- (NSMutableArray *)mutableArrayForKey:(NSString *)key;
@end
