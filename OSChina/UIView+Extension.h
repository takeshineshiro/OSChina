//
//  UIVew+Extension.h
//  OSChina
//
//  Created by baxiang on 14-2-11.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//



@interface UIView (Extension)


// extra geometry
@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize  size;
@property(nonatomic) CGFloat width, height; // normal rect properties
@property(nonatomic) CGFloat left, top, right, bottom; // will not stretch bounds
@property(nonatomic) CGFloat centerX, centerY;  // center x, y

// will stretch bounds
- (void) setLeftStretched:(CGFloat)left;
- (void) setRightStretched:(CGFloat)right;
- (void) setTopStretched:(CGFloat)top;
- (void) setBottomStretched:(CGFloat)bottom;

// set the size of the view with the center unchanged
- (void) setSizeCentered:(CGSize)size;
@end
