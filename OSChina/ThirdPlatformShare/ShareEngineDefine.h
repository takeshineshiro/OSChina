
//
//  weiboDefine.h
//  OSChina
//
//  Created by baxiang on 14-1-23.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//
#ifndef ringvisit_weiboDefine_h
#define ringvisit_weiboDefine_h

typedef enum
{
    sinaWeibo,
    tcWeibo,
    weChat,
    weChatFriend
}ThirdPlatformType;

#define kSinaAppKey       @"3218682351"
#define kSinaSecret       @"0fe435f28bde6e73e8151e44b271fee2"
#define kSinaRedirectURI    @"https://api.weibo.com/oauth2/default.html"

#define kWeChatAppId        @"wxbe41ebca760466e"
#define kWeChatAppKey       @"270e045bf66d6515309e13e71dceb707"

#define kTcAppKey      @"801403753"
#define kTcAppSecret  @"9e610eb9fd7043009053bbe9f2fbb89e"
#define kTcRedirectURI             @"http://d.91dingdong.com/"

#define AccessTokenKey          @"WeiBoAccessToken"
#define ExpirationDateKey       @"WeiBoExpirationDate"
#define ExpireTimeKey           @"WeiBoExpireTime"
#define UserIDKey               @"WeiBoUserID"
#define OpenIdKey               @"WeiBoOpenId"
#define OpenKeyKey              @"WeiBoOpenKey"
#define RefreshTokenKey         @"WeiBoRefreshToken"
#define NameKey                 @"WeiBoName"
#define SSOAuthKey              @"WeiBoIsSSOAuth"

#endif
