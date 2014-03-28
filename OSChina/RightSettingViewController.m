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
#import "UserLoginViewController.h"


@interface userIslogin: NSObject{

    BOOL isLogin;
}

@end
@implementation userIslogin

@end
@implementation RightSettingViewController{

    userIslogin *loginResult;
}

-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Sidebarbg"]];
    UIImage *bgImage =[UIImage imageNamed:@"Sidebarbg"];
    UIImageView *bgView= [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    bgView.image = bgImage;
    [self.view addSubview:bgView];
    [bgView addCenterMotionEffectsXYWithOffset:25];
     loginResult= [[userIslogin alloc] init];
    [loginResult setValue:[NSNumber numberWithBool:NO] forKey:@"isLogin"];
    [loginResult addObserver:self forKeyPath:@"isLogin" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    UIImageView *headIcon= [[UIImageView alloc] initWithFrame:CGRectMake(150, 75, 75, 75)];
    headIcon.image = [UIImage imageNamed:@"icon_user_portraits"];
    [self.view addSubview:headIcon];
    
    UIButton *loginBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(100, headIcon.bottom+20, 180, 40);
    loginBtn.titleLabel.textColor = [UIColor whiteColor];
    [loginBtn setTitle:@"用户登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(userLoginHandle) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_user_login"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    NSArray *userIcons =@[@"icon_myinfo",@"icon_mytweet",@"icon_pushmy",
                         @"icon_comment",@"icon_latest_tweet",@"icon_leavemessage",@"icon_mycollect",@"icon_other"];
    NSArray *userTitles= @[@"我的资料",@"我的动弹",@"@提到我",@"评论",@"最近动弹",@"留言",@"我的收藏",@"其他"];
    for (int i =0; i<3; i++) {
        for (int j=0; j<3; j++) {
            if (j+i*3>=[userIcons count]) {
                break;
            }
            UIButton *userBtn= [UIButton buttonWithType:UIButtonTypeCustom];
            userBtn.frame = CGRectMake(100+j*80, 230+i*60, 100, 40);
            userBtn.titleLabel.textColor = [UIColor whiteColor];
            userBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [userBtn setTitleEdgeInsets:UIEdgeInsetsMake(50.0,-90.0, 0.0,0.0)];
            [userBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0,0.0, 0.0,50.0)];
            [userBtn setTitle:userTitles[j+i*3] forState:UIControlStateNormal];
            [userBtn setImage:[UIImage imageNamed:userIcons[j+i*3]] forState:UIControlStateNormal];
            [self.view addSubview:userBtn];
        }
        
    }
    
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"isLogin"]) {
        if ([[loginResult valueForKey:@"isLogin"] intValue]) {
           
        }
    }

}

-(void) userLoginHandle{
    UserLoginViewController *user= [[UserLoginViewController alloc] initWithLoginResult:^(BOOL isLogin) {
        [loginResult setValue:[NSNumber numberWithBool:isLogin] forKey:@"isLogin"];
    }];
    [self.navigationController pushViewController:user animated:NO];
    [self.sidebarController.contentViewController.view setHidden:YES];

}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    [self.sidebarController.contentViewController.view setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}
@end
