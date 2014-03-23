//
//  CircleLoadingView.h
//  OSChina
//
//  Created by baxiang on 14-3-23.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//
/**
 *  环形加载动态view
 */
#import <UIKit/UIKit.h>

@interface CircleLoadingView : UIView

//default is 1.0f
@property (nonatomic, assign) CGFloat lineWidth;

//default is [UIColor lightGrayColor]
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) float progress;

@property (nonatomic, readonly) BOOL isAnimating;

//use this to init
- (id)initWithFrame:(CGRect)frame;

- (void)startAnimation;
- (void)stopAnimation;

@end


