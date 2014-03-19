//
//  UIApplication+BxExtension.m
//  OSChina
//
//  Created by baxiang on 14-2-12.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "UIApplication+BxExtension.h"

@implementation UIApplication (BxExtension)


- (BOOL)isFirstRun{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"version"]==nil;
}

- (BOOL)isFirstRunCurrentVersion{
    if ([self isFirstRun]) {
        return YES;
    } else {
        return [[NSUserDefaults standardUserDefaults] floatForKey:@"version"] == [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue];
    }
}

- (void)setFirstRun{
    [[NSUserDefaults standardUserDefaults] setFloat:-1 forKey:@"version"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setNotFirstRun{
    [[NSUserDefaults standardUserDefaults] setFloat:[self version] forKey:@"version"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (float)version{
    return [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue];
}

@end
