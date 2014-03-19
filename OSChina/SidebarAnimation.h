//
//  SidebarAnimation.h
//  OSChina
//
//  Created by baxiang on 14-1-21.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define DEG2RAD(degrees) (degrees * M_PI / 180)
#define SIDEBAR_ANIMATIONS \
@"SidebarFacebookAnimation", \
@"SidebarAirbnbAnimation", \
@"SidebarLuvocracyAnimation", \
@"SidebarFeedlyAnimation", \
@"SidebarFlipboardAnimation", \
@"SidebarWunderlistAnimation"


typedef NS_ENUM(NSInteger, SidebarTransitionStyle)
{
    SidebarTransitionStyleFacebook,
    SidebarTransitionStyleAirbnb,
    SidebarTransitionStyleLuvocracy,
    SidebarTransitionStyleFeedly,
    SidebarTransitionStyleFlipboard,
    SidebarTransitionStyleWunderlist
};

typedef NS_ENUM(NSInteger, Side)
{
    LeftSide,
    RightSide,
    CenterMain,
};


@class SidebarAnimation;
@interface SidebarAnimation : NSObject

+ (void)animateContentView:(UIView *)contentView
               sidebarView:(UIView *)sidebarView
                  fromSide:(Side)side
              visibleWidth:(CGFloat)visibleWidth
                  duration:(NSTimeInterval)animationDuration
                completion:(void (^)(BOOL finished))completion;

+ (void)reverseAnimateContentView:(UIView *)contentView
                      sidebarView:(UIView *)sidebarView
                         fromSide:(Side)side
                     visibleWidth:(CGFloat)visibleWidth
                         duration:(NSTimeInterval)animationDuration
                       completion:(void (^)(BOOL finished))completion;

+ (void)resetSidebarPosition:(UIView *)sidebarView;
+ (void)resetContentPosition:(UIView *)contentView;

@end