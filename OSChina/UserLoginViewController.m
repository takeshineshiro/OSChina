//
//  UserLoginViewController.m
//  OSChina
//
//  Created by baxiang on 14-3-26.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "UserLoginViewController.h"

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
    UILabel *userName= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    userName.textAlignment = NSTextAlignmentLeft;
    userName.font = [UIFont systemFontOfSize:18.0f];
    userName.backgroundColor = [UIColor clearColor];
    userName.text = @"  用户名: ";
    //[self.view addSubview:userName];
    userTextFiled= [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self.view addSubview:userTextFiled];
    userTextFiled.background = [UIImage imageNamed:@"bg_login_textfiled"];
    userTextFiled.leftView = userName;
    userTextFiled.leftViewMode = UITextFieldViewModeAlways;
    UILabel *userPass= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    userPass.text = @"  密  码：";
    userPass.font = [UIFont systemFontOfSize:18.0f];
    passwordTextFiled= [[UITextField alloc] initWithFrame:CGRectMake(0, 50, 320, 44)];
    passwordTextFiled.leftView = userPass;
    passwordTextFiled.leftViewMode = UITextFieldViewModeAlways;
    passwordTextFiled.background = [UIImage imageNamed:@"bg_login_textfiled"];
    [self.view addSubview:passwordTextFiled];
    
    UIButton *loginBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(0, passwordTextFiled.bottom+30, 320, 50);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"Navibarbg"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(userLoginHandle) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登     录" forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    
}
-(void) userLoginHandle{
     [[OSAPIClient shareClient] userLoginName:userTextFiled.text passWord:passwordTextFiled.text RequestResult:^(id resultDatas, NSError *error) {
         if ([resultDatas isKindOfClass:[NSString class]]&&[resultDatas isEqualToString:@"1"]) {
              [self.navigationController popViewControllerAnimated:NO];
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
