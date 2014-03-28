//
//  UserLoginViewController.m
//  OSChina
//
//  Created by baxiang on 14-3-26.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "UserLoginViewController.h"
#import "UserInfoViewController.h"
@interface UserLoginViewController ()

@end

@implementation UserLoginViewController{

    UITextField *userTextFiled;
    UITextField *passwordTextFiled;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id) initWithLoginResult:(isLoginSuccess)result{
    self = [super init];
    if (self) {
        self.LoginState = result;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"用户登录"];
    UIButton *backBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame =CGRectMake(0, 0, 60, 44);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [backBtn addTarget:self action:@selector(popCurrViewController) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backBtn setAdjustsImageWhenHighlighted:NO];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn  setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *backItem= [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    UIButton *userName= [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 100, 44)];
    [userName setImage :[UIImage imageNamed:@"icon_myinfo_grey"] forState:UIControlStateNormal];
    [userName setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -5, -10)];
    [userName setTitle:@"用户名:" forState:UIControlStateNormal];
    userName.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [userName setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:userName];
    userTextFiled= [[UITextField alloc] initWithFrame:CGRectMake(100, 20, 200, 44)];
    userTextFiled.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:userTextFiled];
    
    UIImage *seprate= [UIImage imageNamed:@"login_seprateline"];
    UIImageView *sepreLineOne = [[UIImageView alloc] initWithFrame:CGRectMake(20, userTextFiled.bottom, 260, 0.5)];
    sepreLineOne.image = seprate;
    [self.view addSubview:sepreLineOne];
    UIButton *userPass= [[UIButton alloc] initWithFrame:CGRectMake(0, sepreLineOne.bottom+5, 100, 44)];
    [userPass setImage :[UIImage imageNamed:@"icon_password_grey"] forState:UIControlStateNormal];
    [userPass setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -5, -10)];
    [userPass setTitle:@"密  码:" forState:UIControlStateNormal];
    userPass.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [userPass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:userPass];
    passwordTextFiled= [[UITextField alloc] initWithFrame:CGRectMake(100, sepreLineOne.bottom+5, 200, 44)];
    passwordTextFiled.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:passwordTextFiled];
    UIImageView *sepreLineTwo = [[UIImageView alloc] initWithFrame:CGRectMake(20, passwordTextFiled.bottom, 260, 0.5)];
    sepreLineTwo.image = seprate;
    [self.view addSubview:sepreLineTwo];
    UIButton *loginBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(25, passwordTextFiled.bottom+30, 270, 45);
    [loginBtn setBackgroundImage:[[UIImage imageNamed:@"btn_login_blue"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(userLoginHandle) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登    录" forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    
}
-(void) userLoginHandle{
    __weak UserLoginViewController *weakSelf = self;
    userTextFiled.text = @"baxiang1989@163.com";
    passwordTextFiled.text  = @"yangyu1989";
     [[OSAPIClient shareClient] userLoginName:userTextFiled.text passWord:passwordTextFiled.text RequestResult:^(id resultDatas, NSError *error) {
         if ([resultDatas isKindOfClass:[NSString class]]&&[resultDatas isEqualToString:@"1"]) {
                UserInfoViewController  *userInfo = [[UserInfoViewController alloc] init];
             [weakSelf.navigationController pushViewController:userInfo animated:NO];
//               weakSelf.LoginState(YES);
//              [weakSelf.navigationController popViewControllerAnimated:NO];
         }else{
              //weakSelf.LoginState(NO);
         }
     }];
 
}
-(void) popCurrViewController{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
