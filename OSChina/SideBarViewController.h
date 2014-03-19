//
//  SideBarViewController.h
//  OSChina
//
//  Created by baxiang on 14-1-21.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidebarAnimation.h"

@protocol SideBarViewControllerDelegate;

@interface SideBarViewController : UIViewController<UIGestureRecognizerDelegate>


@property (strong, nonatomic) UIViewController *contentViewController;
@property (strong, nonatomic) UIViewController *leftSidebarViewController;
@property (strong, nonatomic) UIViewController *rightSidebarViewController;

@property (assign, nonatomic) NSTimeInterval animationDuration;
@property (assign, nonatomic) CGFloat visibleWidth;
@property (assign, nonatomic) BOOL sidebarIsPresenting;
@property (assign, nonatomic) Side currentSide;
@property (assign, nonatomic) id<SideBarViewControllerDelegate> delegate;

- (id)initWithContentViewController:(UIViewController *)contentViewController
          leftSidebarViewController:(UIViewController *)leftSidebarViewController;

- (id)initWithContentViewController:(UIViewController *)contentViewController
         rightSidebarViewController:(UIViewController *)rightSidebarViewController;

- (id)initWithContentViewController:(UIViewController *)contentViewController
          leftSidebarViewController:(UIViewController *)leftSidebarViewController
         rightSidebarViewController:(UIViewController *)rightSidebarViewController;

- (void)dismissSidebarViewController;
- (void)presentLeftSidebarViewController;
//- (void)presentLeftSidebarViewControllerWithStyle:(SidebarTransitionStyle)transitionStyle;
- (void)presentRightSidebarViewController;
//- (void)presentRightSidebarViewControllerWithStyle:(SidebarTransitionStyle)transitionStyle;

@end

@protocol SideBarViewControllerDelegate <NSObject>

@optional
- (void)sidebarController:(SideBarViewController *)sidebarController willShowViewController:(UIViewController *)viewController;
- (void)sidebarController:(SideBarViewController *)sidebarController didShowViewController:(UIViewController *)viewController;
- (void)sidebarController:(SideBarViewController *)sidebarController willHideViewController:(UIViewController *)viewController;
- (void)sidebarController:(SideBarViewController *)sidebarController didHideViewController:(UIViewController *)viewController;
@end



@interface UIViewController(SideBarViewController)

@property (strong, readonly, nonatomic) SideBarViewController *sidebarController;

@end