//
//  BaseNavigationController.h
//  OSChina
//
//  Created by baxiang on 14-3-18.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController


- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer;
@end
