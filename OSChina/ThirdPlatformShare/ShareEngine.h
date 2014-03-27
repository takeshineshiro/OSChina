//
//  ShareEngine.h
//  OSChina
//
//  Created by baxiang on 14-1-23.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ShareEngineDefine.h"
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"
@protocol ShareEngineDelegate;

@interface ShareEngine : NSObject<WXApiDelegate,WeiboSDKDelegate,WeiboRequestDelegate,WeiboAuthDelegate>
{
     WeiboApi           *tcWeiboApi;
}
@property (nonatomic, assign) id<ShareEngineDelegate> delegate;

@property (nonatomic, strong) NSString *sinaToken;
+ (ShareEngine *) sharedInstance;

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;

- (void)registerApp;

/**
 *@description 判断是否登录
 *@param weibotype:微博类型
 */
- (BOOL)isLogin:(ThirdPlatformType)weiboType;

/**
 *  腾讯微博登录目前腾讯微博不支持sso
 *
 *  @param currController 当前的viewcontroller
 */
-(void)tencentWeiBoLogin:(UIViewController*) currController;
/**
 *@description 微博登录
 *@param weibotype:微博类型
 */
- (void)loginWithType:(ThirdPlatformType)weiboType;

/**
 *@description 退出微博
 *@param weibotype:微博类型
 */
- (void)logOutWithType:(ThirdPlatformType)weiboType;

/**
 *@description 发送微信消息
 *@param message:文本消息 url:分享链接 weibotype:微信消息类型
 */
- (void)sendWeChatMessage:(NSString*)message WithUrl:(NSString*)url WithType:(ThirdPlatformType)weiboType;

/**
 *@description 发送微博成功
 *@param message:文本消息 weibotype:微博类型
 */
- (void)sendShareMessage:(NSString*)message WithType:(ThirdPlatformType)weiboType;

@end


/**
 * @description 微博登录及发送微博类容结果的回调
 */
@protocol ShareEngineDelegate <NSObject>
@optional
/**
 *@description 发送微博成功
 *@param weibotype:微博类型
 */
- (void)shareEngineDidLogIn:(ThirdPlatformType)weibotype;

/**
 *@description 发送微博成功
 *@param weibotype:微博类型
 */
- (void)shareEngineDidLogOut:(ThirdPlatformType)weibotype;

/**
 *@description 发送微博成功
 */
- (void)shareEngineSendSuccess;

/**
 *@descrition 发送微博失败
 *@param error:失败代码
 */
- (void)shareEngineSendFail:(NSError *)error;

-(void) shareEngineAuthFail:(ThirdPlatformType)weibotype error:(NSError *)error;
@end
