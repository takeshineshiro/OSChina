//
//  SidebarAnimation.m
//  OSChina
//
//  Created by baxiang on 14-1-21.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "SidebarAnimation.h"

@implementation SidebarAnimation

+ (void)animateContentView:(UIView *)contentView sidebarView:(UIView *)sidebarView fromSide:(Side)side visibleWidth:(CGFloat)visibleWidth duration:(NSTimeInterval)animationDuration completion:(void (^)(BOOL))completion
{
    
}

+ (void)reverseAnimateContentView:(UIView *)contentView sidebarView:(UIView *)sidebarView fromSide:(Side)side visibleWidth:(CGFloat)visibleWidth duration:(NSTimeInterval)animationDuration completion:(void (^)(BOOL))completion
{
    
}

+ (void)resetSidebarPosition:(UIView *)sidebarView
{
    CATransform3D resetTransform = CATransform3DIdentity;
    resetTransform = CATransform3DRotate(resetTransform, DEG2RAD(0), 1, 1, 1);
    resetTransform = CATransform3DScale(resetTransform, 1.0, 1.0, 1.0);
    resetTransform = CATransform3DTranslate(resetTransform, 0.0, 0.0, 0.0);
    sidebarView.layer.transform = resetTransform;
    
    CGRect resetFrame = sidebarView.frame;
    resetFrame.origin.x = 0;
    resetFrame.origin.y = 0;
    sidebarView.frame = resetFrame;
    
    [sidebarView.superview sendSubviewToBack:sidebarView];
    sidebarView.layer.zPosition = 0;
}

+ (void)resetContentPosition:(UIView *)contentView
{
    CATransform3D resetTransform = CATransform3DIdentity;
    resetTransform = CATransform3DRotate(resetTransform, DEG2RAD(0), 1, 1, 1);
    resetTransform = CATransform3DScale(resetTransform, 1.0, 1.0, 1.0);
    resetTransform = CATransform3DTranslate(resetTransform, 0.0, 0.0, 0.0);
    contentView.layer.transform = resetTransform;
    
    CGRect resetFrame = contentView.frame;
    resetFrame.origin.x = 0;
    resetFrame.origin.y = 0;
    contentView.frame = resetFrame;
    
    [contentView.superview bringSubviewToFront:contentView];
    contentView.layer.zPosition = 0;
}

@end

