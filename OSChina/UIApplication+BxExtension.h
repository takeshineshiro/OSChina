//
//  UIApplication+BxExtension.h
//  OSChina
//
//  Created by baxiang on 14-2-12.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (BxExtension)

- (BOOL)isFirstRun;
- (BOOL)isFirstRunCurrentVersion;
- (void)setFirstRun;
- (void)setNotFirstRun;
- (float)version;
@end
