//
//  ShareEngine.m
//  ShareEngineExample
//
//  Created by 陈欢 on 13-10-8.
//  Copyright (c) 2013年 陈欢. All rights reserved.
//

#import "ShareEngine.h"

@implementation ShareEngine

static ShareEngine *sharedSingleton_ = nil;

+ (ShareEngine *) sharedInstance
{

    static ShareEngine *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance= [[ShareEngine alloc] init];
    });
    return shareInstance;
}



- (id)init
{
    self = [super init];
    if (self)
    {
        //腾讯微博注册
        tcWeiboApi= [[WeiboApi alloc]initWithAppKey:kTcAppKey andSecret:kTcAppSecret andRedirectUri:kTcRedirectURI andAuthModeFlag:0 andCachePolicy:0] ;
        //新浪微博注册
        //[WeiboSDK enableDebugMode:YES];
        [WeiboSDK registerApp:kSinaAppKey];
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    BOOL weiboRet = NO;
    //处理新浪分享
    if ([url.absoluteString hasPrefix:@"sina"])
    {
        weiboRet = [WeiboSDK handleOpenURL:url delegate:self];
    }
    // 处理腾讯分享
    else if([url.absoluteString hasPrefix:@"wb"])
    {
        weiboRet = [tcWeiboApi handleOpenURL:url];
    }
    else
    {
        weiboRet = [WXApi handleOpenURL:url delegate:self];
    }
    return weiboRet;
}

#pragma mark - weibo method

/**
 * @description 存储内容读取
 */
- (void)registerApp
{
    //向微信注册
    [WXApi registerApp:kWeChatAppId];
    
    //[self tcWeiboReadAuthData];
    //[self sinaWeiboReadAuthData];
}
/**
 *  判断当前第三方平台是否登录
 *
 *  @param weiboType 第三方平台
 *
 *  @return 是否登录
 */
- (BOOL)isLogin:(WeiboType)weiboType
{
    if (sinaWeibo == weiboType)
    {
        //return [sinaWeiboEngine isLoggedIn];
    }
    else if(tcWeibo == weiboType)
    {
        //return [tcWeiboEngine isLoggin];
    }
        return NO;
    
}

- (void)loginWithType:(WeiboType)weiboType
{
    if (sinaWeibo == weiboType)
    {
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = kSinaRedirectURI;
        request.scope = @"all";
        [WeiboSDK sendRequest:request];
    }
    else if(tcWeibo == weiboType)
    {
        [tcWeiboApi loginWithDelegate:self andRootController:_tcWeiboVC];
    }
   
}
/**
 *  第三平台登出
 *
 *  @param weiboType 第三平台类型
 */
- (void)logOutWithType:(WeiboType)weiboType
{
    if (sinaWeibo == weiboType)
    {
        //[sinaWeiboEngine logOut];
    }
    else if(tcWeibo == weiboType)
    {
        //[tcWeiboEngine logOutWithDelegate:self];
    }
    else
    {
        
    }
}

- (void)sendWeChatMessage:(NSString*)message WithUrl:(NSString*)url WithType:(WeiboType)weiboType
{
    if(weChat == weiboType)
    {
        [self sendAppContentWithMessage:message WithUrl:url WithScene:WXSceneSession];
        return;
    }
    else if(weChatFriend == weiboType)
    {
        [self sendAppContentWithMessage:message WithUrl:url WithScene:WXSceneTimeline];
        return;
    }
}

- (void)sendShareMessage:(NSString*)message WithType:(WeiboType)weiboType
{
    if (NO == [self isLogin:weiboType])
    {
        [self loginWithType:weiboType];
        return;
    }
    if (sinaWeibo == weiboType)
    {
       // [self sinaWeiboPostStatus:message];
    }
    else if(tcWeibo == weiboType)
    {
       // [self tcWeiboPostStatus:message];
    }
    
}

#pragma mark - weibo respon
- (void)loginSuccess:(WeiboType)weibotype
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(shareEngineDidLogIn:)])
    {
        [self.delegate shareEngineDidLogIn:weibotype];
    }
}

- (void)logOutSuccess:(WeiboType)weibotype
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(shareEngineDidLogOut:)])
    {
        [self.delegate shareEngineDidLogOut:weibotype];
    }
}

- (void)loginFail
{

}

- (void)weiboSendSuccess
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(shareEngineSendSuccess)])
    {
        [self.delegate shareEngineSendSuccess];
    }
}

- (void)weiboSendFail:(NSError *)error
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(shareEngineSendFail:)])
    {
        [self.delegate shareEngineSendFail:error];
    }
//    if (20019 == error.code)
//    {
//        NSLog(@"重复内容!");
//    }
//    else
//    {
//        NSLog(@"发送失败!");
//    }
}





#pragma mark - wechat delegate
- (void)weChatPostStatus:(NSString*)message
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

- (void)weChatFriendPostStatus:(NSString*)message
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

- (void)sendAppContentWithMessage:(NSString*)appMessage WithUrl:(NSString*)appUrl WithScene:(int)scene
{
    // 发送内容给微信
    
    WXMediaMessage *message = [WXMediaMessage message];
    if (WXSceneTimeline == scene)
    {
        message.title = appMessage;
    }
    else
    {
        message.title = @"叮咚上门";
    }
    message.description = appMessage;
    [message setThumbImage:[UIImage imageNamed:@"ico"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = appUrl;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    [WXApi sendReq:req];
}

-(void) onSentTextMessage:(BOOL) bSent
{
    // 通过微信发送消息后， 返回本App
    //    NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
    //    NSString *strMsg = [NSString stringWithFormat:@"发送文本消息结果:%u", bSent];
    //
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
    //    [alert release];
    if (YES == bSent)
    {
        [self weiboSendSuccess];
    }
    else
    {
        [self weiboSendFail:nil];
    }
}

-(void) onSentMediaMessage:(BOOL) bSent
{
    // 通过微信发送消息后， 返回本App
    NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
    NSString *strMsg = [NSString stringWithFormat:@"发送媒体消息结果:%u", bSent];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}

-(void) onSentAuthRequest:(NSString *) userName accessToken:(NSString *) token expireDate:(NSDate *) expireDate errorMsg:(NSString *) errMsg
{
    
}

-(void) onShowMediaMessage:(WXMediaMessage *) message
{
    // 微信启动， 有消息内容。
    //    WXAppExtendObject *obj = message.mediaObject;
    
    //    shopDetailViewController *sv = [[shopDetailViewController alloc] initWithNibName:@"shopDetailViewController" bundle:nil];
    //    sv.m_sShopID = obj.extInfo;
    //    [self.navigationController pushViewController:sv animated:YES];
    //    [sv release];
    
    //    NSString *strTitle = [NSString stringWithFormat:@"消息来自微信"];
    //    NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", message.title, message.description, obj.extInfo, message.thumbData.length];
    //
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
    //    [alert release];
}

-(void) onRequestAppMessage
{
    // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
}

-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        [self onRequestAppMessage];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        [self onShowMediaMessage:temp.message];
    }
    
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (0 == resp.errCode)
        {
            [self weiboSendSuccess];
        }
        else
        {
            [self weiboSendFail:nil];
        }
        //        NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
        //        NSString *strMsg = [NSString stringWithFormat:@"发送媒体消息结果:%d", resp.errCode];
        //
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
        //        [alert release];
    }
    //    else if([resp isKindOfClass:[SendAuthResp class]])
    //    {
    //        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
    //        NSString *strMsg = [NSString stringWithFormat:@"Auth结果:%d", resp.errCode];
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    //        [alert release];
    //    }
}

/**
 *  新浪微博授权的回调
 *
 *  @param response <#response description#>
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = @"认证结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
       // self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        
       
    }
}



/**
 * @brief   重刷授权成功后的回调
 * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
 * @return  无返回
 */
- (void)DidAuthRefreshed:(WeiboApiObject *)wbobj
{
    
    
    //UISwitch
    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r openid = %@\r appkey=%@ \r appsecret=%@\r",wbobj.accessToken, wbobj.openid, wbobj.appKey, wbobj.appSecret];
    
    NSLog(@"result = %@",str);
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
       // [self showMsg:str];
    });
    //[str release];
    
}

/**
 * @brief   重刷授权失败后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
- (void)DidAuthRefreshFail:(NSError *)error
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //[self showMsg:str];
    });
    //[str release];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
 * @return  无返回
 */
- (void)DidAuthFinished:(WeiboApiObject *)wbobj
{
    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r\n openid = %@\r\n appkey=%@ \r\n appsecret=%@ \r\n refreshtoken=%@ ", wbobj.accessToken, wbobj.openid, wbobj.appKey, wbobj.appSecret, wbobj.refreshToken];
    
    NSLog(@"result = %@",str);
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //[self showMsg:str];
    });
    
    
    // NSLog(@"after add pic");
   // [str release];
}

/**
 * @brief   取消腾讯微博的回调
 * @param   INPUT   wbapi   weiboapi 对象，取消授权后，授权信息会被清空
 * @return  无返回
 */
- (void)DidAuthCanceled:(WeiboApi *)wbapi_
{
    
}

/**
 * @brief   腾讯微博授权失败的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
- (void)DidAuthFailWithError:(NSError *)error
{
    NSString *str = [[NSString alloc] initWithFormat:@"get token error, errcode = %@",error.userInfo];
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //[self showMsg:str];
    });
   }

/**
 * @brief   授权成功后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
-(void)didCheckAuthValid:(BOOL)bResult suggest:(NSString *)strSuggestion
{
    NSString *str = [[NSString alloc] initWithFormat:@"ret=%d, suggestion = %@", bResult, strSuggestion];
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //[self showMsg:str];
    });
    //[str release];
}





- (void)createSuccess:(NSDictionary *)dict {
    NSLog(@"%s %@", __FUNCTION__,dict);
    if ([[dict objectForKey:@"ret"] intValue] == 0)
    {
        [self weiboSendSuccess];
        NSLog(@"发送成功！");
    }
    else
    {
        [self weiboSendFail:nil];
        NSLog(@"发送失败！");
    }
}

- (void)createFail:(NSError *)error
{
    [self weiboSendFail:nil];
    NSLog(@"发送失败!error is %@",error);
}

@end
