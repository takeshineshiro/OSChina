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
#import "LoginUser.h"
#import "UIImageView+WebCache.h"
#import "User.h"
@interface userIslogin: NSObject{

    BOOL isLogin;
}

@end
@implementation userIslogin

@end
@implementation RightSettingViewController{

    userIslogin *loginResult;
    UIImageView *headIcon;
    UILabel *userName;
    UIImageView *sepre_ver;
    UILabel *fans;
    UIImageView *sepre_hori;
    UILabel *followers;
    UIImageView *sepre_ver_bottom;
    UIButton *logoutBtn;
    UIButton *loginBtn;
}

-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Sidebarbg"]];
    UIImage *bgImage =[UIImage imageNamed:@"Sidebarbg"];
    UIImageView *bgView= [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    bgView.image = bgImage;
    [self.view addSubview:bgView];
    [bgView addCenterMotionEffectsXYWithOffset:25];
    
    headIcon = [[UIImageView alloc] initWithFrame:CGRectMake((240-80)/2+80, 75, 80, 80)];
    headIcon.image = [UIImage imageNamed:@"icon_user_portraits"];
    headIcon.layer.masksToBounds = YES;
    headIcon.layer.cornerRadius = 40.0f;
    [self.view addSubview:headIcon];
    
    
    logoutBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(200,self.view.height-50, 100, 40);
    logoutBtn.titleLabel.textColor = [UIColor whiteColor];
    [logoutBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [logoutBtn setTitle:@"账户退出" forState:UIControlStateNormal];
    [logoutBtn setImage:[UIImage imageNamed:@"icon_logout"] forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(userLogoutHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    logoutBtn.hidden = YES;
//    NSArray *userIcons =@[@"icon_myinfo",@"icon_mytweet",@"icon_pushmy",
//                         @"icon_comment",@"icon_latest_tweet",@"icon_leavemessage",@"icon_mycollect",@"icon_other"];
//    NSArray *userTitles= @[@"我的资料",@"我的动弹",@"@提到我",@"评论",@"最近动弹",@"留言",@"我的收藏",@"其他"];
//    for (int i =0; i<3; i++) {
//        for (int j=0; j<3; j++) {
//            if (j+i*3>=[userIcons count]) {
//                break;
//            }
//            UIButton *userBtn= [UIButton buttonWithType:UIButtonTypeCustom];
//            userBtn.frame = CGRectMake(100+j*80, 230+i*60, 100, 40);
//            userBtn.titleLabel.textColor = [UIColor whiteColor];
//            userBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//            [userBtn setTitleEdgeInsets:UIEdgeInsetsMake(50.0,-90.0, 0.0,0.0)];
//            [userBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0,0.0, 0.0,50.0)];
//            [userBtn setTitle:userTitles[j+i*3] forState:UIControlStateNormal];
//            [userBtn setImage:[UIImage imageNamed:userIcons[j+i*3]] forState:UIControlStateNormal];
//            [self.view addSubview:userBtn];
//        }
//        
//    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    [self.sidebarController.contentViewController.view setHidden:NO];
    NSArray *userArray= [LoginUser searchWithWhere:nil orderBy:nil offset:0 count:1];
    if ([userArray count]) {
        if (loginBtn) {
            [loginBtn removeFromSuperview];
        }
        
        LoginUser *user= [userArray lastObject];
        
        [headIcon setImageWithURL:[NSURL URLWithString:user.portrait] placeholderImage:[UIImage imageNamed:@"icon_user_portraits"]];
        userName= [[UILabel alloc] initWithFrame:CGRectMake(80, headIcon.bottom+10, 240, 20)];
        userName.textAlignment = NSTextAlignmentCenter;
        userName.font = [UIFont systemFontOfSize:18.0f];
        userName.textColor = [UIColor whiteColor];
        userName.backgroundColor = [UIColor clearColor];
        userName.text = user.name;
        [self.view addSubview:userName];
       
        sepre_ver= [[UIImageView alloc] initWithFrame:CGRectMake(120,userName.bottom+10, 160, 0.5)];
        sepre_ver.image =  [UIImage imageNamed:@"bg_separatever_white"];
        [self.view addSubview:sepre_ver];
        fans= [[UILabel alloc] initWithFrame:CGRectMake(130, sepre_ver.bottom+5, 100, 20)];
        fans.textColor = [UIColor whiteColor];
        fans.backgroundColor = [UIColor clearColor];
        fans.text =[NSString stringWithFormat:@"%@ 粉丝",user.fanscount];
        [self.view addSubview:fans];
        sepre_hori= [[UIImageView alloc] initWithFrame:CGRectMake(200,sepre_ver.bottom+5, 0.5, 20)];
        sepre_hori.image =  [UIImage imageNamed:@"bg_separatehori_white"];
        [self.view addSubview:sepre_hori];
        followers= [[UILabel alloc] initWithFrame:CGRectMake(220, sepre_ver.bottom+5, 100, 20)];
        followers.textColor = [UIColor whiteColor];
        followers.backgroundColor = [UIColor clearColor];
        followers.text =[NSString stringWithFormat:@"%@ 粉丝",user.followerscount];
        [self.view addSubview:followers];
        sepre_ver_bottom= [[UIImageView alloc] initWithFrame:CGRectMake(120,followers.bottom+5, 160, 0.5)];
        sepre_ver_bottom.image =  [UIImage imageNamed:@"bg_separatever_white"];
        [self.view addSubview:sepre_ver_bottom];
        [self addUserBtn];
        logoutBtn.hidden = NO;
       
    }else{
        
        [self addLoginBtn];
        [self addUserBtn];
    
    }
}
//-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"isLogin"]) {
//        if ([[loginResult valueForKey:@"isLogin"] intValue]) {
//           
//        }
//    }
//
//}
-(void) addUserBtn{

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
-(void) addLoginBtn{
    loginBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(80+(240-180)/2, headIcon.bottom+20, 180, 40);
    loginBtn.titleLabel.textColor = [UIColor whiteColor];
    [loginBtn setTitle:@"赶紧登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(userLoginHandle) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_user_login"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];


}
-(void)userLogoutHandle{
    [LKDBHelper clearTableData:[LoginUser class]];
    headIcon.image = [UIImage imageNamed:@"icon_user_portraits"];
    logoutBtn.hidden = YES;
    [userName removeFromSuperview];
    [sepre_ver removeFromSuperview];
    [fans removeFromSuperview];
    [sepre_hori removeFromSuperview];
    [sepre_ver_bottom removeFromSuperview];
    [followers removeFromSuperview];
    [self addLoginBtn];


}
-(void) userLoginHandle{
    UserLoginViewController *user= [[UserLoginViewController alloc] initWithLoginResult:^(BOOL isLogin) {
        [loginResult setValue:[NSNumber numberWithBool:isLogin] forKey:@"isLogin"];
    }];
    [self.navigationController pushViewController:user animated:NO];
    [self.sidebarController.contentViewController.view setHidden:YES];
    }

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}
@end
