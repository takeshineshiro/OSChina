//
//  NSDictionary+BxExtension.m
//  OSChina
//
//  Created by baxiang on 14-2-12.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "NSDictionary+BxExtension.h"

@implementation NSDictionary (BxExtension)


- (id)objectForKey:(id)key withClass:(Class)class{
    id obj = [self objectForKey:key];
    
   // NSString *str = [NSString stringWithFormat:@"------当前值不是----- %@", NSStringFromClass(class)];
   // NSAssert(![obj isKindOfClass:class], str);
    if (obj == [NSNull null]|| ![obj isKindOfClass:class]) {
        return nil;
    }
    return obj;
}

- (NSString *)stringForKey:(NSString *)key{
    return [self objectForKey:key withClass:[NSString class]];
}

- (NSNumber *)numberForKey:(NSString *)key{
    return [self objectForKey:key withClass:[NSNumber class]];
}

- (int)intForKey:(NSString *)key{
    return [[self numberForKey:key] intValue];
}

- (float)floatForKey:(NSString *)key{
    return [[self numberForKey:key] floatValue];
}

- (NSDictionary *)dictionaryForKey:(NSString *)key{
    return [self objectForKey:key withClass:[NSDictionary class]];
}

- (NSArray *)arrayForKey:(NSString *)key{
    return [self objectForKey:key withClass:[NSArray class]];
}

- (NSMutableDictionary *)mutableDictionaryForKey:(NSString *)key{
    NSDictionary *dict = [self dictionaryForKey:key];
    if (dict) {
        return [NSMutableDictionary dictionaryWithDictionary:dict];
    } else {
        return [NSMutableDictionary dictionary];
    }
}

- (NSMutableArray *)mutableArrayForKey:(NSString *)key{
    NSArray *arr = [self arrayForKey:key];
    if (arr) {
        return [NSMutableArray arrayWithArray:arr];
    } else {
        return [NSMutableArray array];
    }
}

@end
