//
//  RightSettingViewController.m
//  OSChina
//
//  Created by baxiang on 14-1-21.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "RightSettingViewController.h"
#import "NewsDetailViewController.h"
#import "SideBarViewController.h"
#import "UIView+MotionEffect.h"
@implementation RightSettingViewController

-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Sidebarbg"]];
    UIImage *bgImage =[UIImage imageNamed:@"Sidebarbg"];
    UIImageView *bgView= [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    bgView.image = bgImage;
    [self.view addSubview:bgView];
    [bgView addCenterMotionEffectsXYWithOffset:25];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissThisViewController)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    [self.sidebarController.contentViewController.view setHidden:NO];
}
- (void)dismissThisViewController
{
     NewsDetailViewController *news= [[NewsDetailViewController alloc] init];
    [self.navigationController pushViewController:news animated:YES];
    [self.sidebarController.contentViewController.view setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}
@end
