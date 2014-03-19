//
//  UncaughtExceptionHandler.h
//  OSChina
//
//  Created by baxiang on 14-3-17.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UncaughtExceptionHandler : NSObject

+ (void)setDefaultHandler;
@end

void SignalHandler(int signal);
void HandleException(NSException *exception);
void InstallUncaughtExceptionHandler();

