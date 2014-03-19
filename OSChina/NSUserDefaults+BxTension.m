//
//  NSUserDefaults+BxTension.m
//  OSChina
//
//  Created by baxiang on 14-2-12.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "NSUserDefaults+BxTension.h"

@implementation NSUserDefaults (BxExtension)

+ (void)saveObject:(id)object forKey:(NSString *)key
{
    NSUserDefaults *defaults = [self standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

/* convenience method to return a string for a given key */
+ (id)retrieveObjectForKey:(NSString *)key
{
    return [[self standardUserDefaults] objectForKey:key];
}

/* convenience method to delete a value for a given key */
+ (void)deleteObjectForKey:(NSString *)key
{
    NSUserDefaults *defaults = [self standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

@end
