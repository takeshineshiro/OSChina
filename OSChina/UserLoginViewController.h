//
//  UserLoginViewController.h
//  OSChina
//
//  Created by baxiang on 14-3-26.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^isLoginSuccess)(BOOL isLogin);
@interface UserLoginViewController : BaseViewController

@property (nonatomic,strong) isLoginSuccess LoginState;
-(id) initWithLoginResult:(isLoginSuccess)result;
@end
