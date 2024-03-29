//
//  SidebarLuvocracyAnimation.m
//  OSChina
//
//  Created by baxiang on 14-1-21.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "SidebarLuvocracyAnimation.h"

@implementation SidebarLuvocracyAnimation

+ (void)animateContentView:(UIView *)contentView sidebarView:(UIView *)sidebarView fromSide:(Side)side visibleWidth:(CGFloat)visibleWidth duration:(NSTimeInterval)animationDuration completion:(void (^)(BOOL))completion
{
    [self resetSidebarPosition:sidebarView];
    [self resetContentPosition:contentView];
    
    // Animation settings for content view
    CATransform3D contentTransform = CATransform3DIdentity;
    contentTransform.m34 = -1.0f / 800.0f;
    contentView.layer.zPosition = 100;
    
    // Animation settings for sidebar view
    CATransform3D sidebarTransform = CATransform3DIdentity;
    sidebarTransform = CATransform3DScale(sidebarTransform, 1.7, 1.7, 1.7);
    sidebarView.layer.transform = sidebarTransform;
    
    sidebarTransform = CATransform3DIdentity;
    sidebarTransform = CATransform3DScale(sidebarTransform, 1.0, 1.0, 1.0);
    
    if(side == LeftSide)
    {
        contentTransform = CATransform3DTranslate(contentTransform, visibleWidth - (contentView.frame.size.width / 2 * 0.4), 0.0, 0.0);
        contentTransform = CATransform3DScale(contentTransform,0.8, 0.8, 0.8);
    }
    else
    {
        contentTransform = CATransform3DTranslate(contentTransform, 0 - visibleWidth + (contentView.frame.size.width / 2 * 0.4), 0.0, 0.0);
        contentTransform = CATransform3DScale(contentTransform, 0.7, 0.7, 0.7);
    }
    
    
    // Animate
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         contentView.layer.transform = contentTransform;
                         sidebarView.layer.transform = sidebarTransform;
                     }
                     completion:^(BOOL finished) {
                         completion(finished);
                     }];
}


+ (void)reverseAnimateContentView:(UIView *)contentView sidebarView:(UIView *)sidebarView fromSide:(Side)side visibleWidth:(CGFloat)visibleWidth duration:(NSTimeInterval)animationDuration completion:(void (^)(BOOL))completion
{
    // Animation settings for content view
    CATransform3D contentTransform = CATransform3DIdentity;
    contentTransform.m34 = -1.0f / 800.0f;
    contentView.layer.zPosition = 100;
    contentTransform = CATransform3DTranslate(contentTransform, 0.0, 0.0, 0.0);
    contentTransform = CATransform3DScale(contentTransform, 1.0, 1.0, 1.0);
    
    // Animation settings for menu view
    __block CATransform3D sidebarTransform = CATransform3DIdentity;
    sidebarTransform = CATransform3DScale(sidebarTransform, 1.7, 1.7, 1.7);
    
    
    // Animate
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         contentView.layer.transform = contentTransform;
                         sidebarView.layer.transform = sidebarTransform;
                     }
                     completion:^(BOOL finished) {
                         completion(finished);
                         sidebarTransform = CATransform3DIdentity;
                         sidebarTransform = CATransform3DScale(sidebarTransform, 1.0, 1.0, 1.0);
                         sidebarView.layer.transform = sidebarTransform;
                     }];
}


@end

