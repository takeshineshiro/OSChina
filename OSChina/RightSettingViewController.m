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
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissThisViewController)];
//    [self.view addGestureRecognizer:tapGesture];
    
    UIImageView *headIcon= [[UIImageView alloc] initWithFrame:CGRectMake(150, 75, 75, 75)];
    headIcon.image = [UIImage imageNamed:@"icon_user_portraits"];
    [self.view addSubview:headIcon];
    
    UIButton *loginBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(100, headIcon.bottom+20, 180, 40);
    loginBtn.titleLabel.textColor = [UIColor whiteColor];
    [loginBtn setTitle:@"用户登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_user_login"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    
    NSArray *userIcons =@[@"icon_user_collect",@"icon_user_collect",@"icon_user_collect",
                         @"icon_user_collect",@"icon_user_collect",@"icon_user_collect",@"icon_user_collect",@"icon_user_collect"];
    NSArray *userTitles= @[@"我的资料",@"我的动弹",@"@提到我",@"评论",@"最近动弹",@"留言",@"收藏",@"其他"];
    for (int i =0; i<3; i++) {
        for (int j=0; j<3; j++) {
            if (j+i*3>=[userIcons count]) {
                break;
            }
            UIButton *userBtn= [UIButton buttonWithType:UIButtonTypeCustom];
            userBtn.frame = CGRectMake(100+j*80, loginBtn.bottom+i*60, 100, 100);
            userBtn.titleLabel.textColor = [UIColor whiteColor];
            userBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [userBtn setTitleEdgeInsets:UIEdgeInsetsMake(60.0,-90.0, 0.0,0.0)];
            [userBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0,0.0, 0.0,50.0)];
            [userBtn setTitle:userTitles[j+i*3] forState:UIControlStateNormal];
            [userBtn setImage:[UIImage imageNamed:userIcons[j+i*3]] forState:UIControlStateNormal];
            [self.view addSubview:userBtn];
        }
        
    }
    
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
