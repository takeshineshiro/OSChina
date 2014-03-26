//
//  OSAPIClient.m
//  OSChina
//
//  Created by baxiang on 14-1-23.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "OSAPIClient.h"
#import "STDbHandle.h"
#import "AFXMLRequestOperation.h"
#import "XMLParser.h"
#import "AppCache.h"
#import "News.h"
#import "Blog.h"
#import "Post.h"
#import "Tweet.h"
#import "NewsObject.h"
#import "BlogObject.h"
static NSString *const kAPIBaseURLString = @"http://www.oschina.net/action/api/";
/*资讯列表*/
static NSString *const kNewsListURLString = @"news_list";
/*资讯详情*/
static NSString *const kNewsDetailURLString = @"news_detail";
/*博客详情*/
static NSString *const kBlogDetailURLString = @"blog_detail";
/*讨论区列表*/
static NSString *const kCommunityListURLString = @"post_list";
static NSString *const kTweetListURLString = @"tweet_list";
@implementation OSAPIClient


+(OSAPIClient*) shareClient{
    static OSAPIClient *_client =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _client = [[OSAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
    });
    return _client;
}

-(BOOL)currNetworkReachabilityStatus{
    if (self.networkReachabilityStatus== AFNetworkReachabilityStatusNotReachable) {
        return NO;
    }
    return YES;
}
-(id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
       // [self unregisterHTTPOperationClass:[AFJSONRequestOperation class]];
       // [self unregisterHTTPOperationClass:[AFImageRequestOperation class]];
        [self registerHTTPOperationClass:[AFXMLRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/xml"];
        
    }
    return self;
}

-(NSString*) currRequestUniqueIdentifier:(NSURL *) identifie  {
    
   NSMutableString *str = [NSMutableString stringWithFormat:@"%@ %@",kAPIBaseURLString,identifie];
    return [str MD5];
    
}
#pragma mark 获取新闻列表信息
-(void)getNewslistWithPageIndex:(NSInteger) pageIndex RequestResult:(RequestResultBlocks) blocks{
    NSMutableDictionary *paramters = [NSMutableDictionary dictionaryWithCapacity:3];
    [paramters setObject:[NSNumber numberWithInteger:1] forKey:@"catalog"];
    [paramters setObject:[NSNumber numberWithInteger:pageIndex] forKey:@"pageIndex"];
    [paramters setObject:[NSNumber numberWithInteger:20] forKey:@"pageSize"];
    [self getPath:@"news_list" parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [[XMLParser shareInstance] parseData:operation.responseData];
        NSArray *newsArray = [XMLParser getDataAtPath:@"oschina.newslist.news" fromResultObject:dict];
        NSArray *news = [NewsObject entityWithArray:newsArray];
        //[[AppCache shareCache] saveCacheData: operation.responseData forKey:[self currRequestUniqueIdentifier:operation.request.URL]];
        if (pageIndex ==0) {
            [self saveNewsList:news AndUniqueIdentifier:[self currRequestUniqueIdentifier:operation.request.URL]];
        }
        blocks(news,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (![self currNetworkReachabilityStatus]) {
            NSString *condition = [NSString stringWithFormat:@"identifier=\'%@\'",[self currRequestUniqueIdentifier:operation.request.URL]];
            NSArray *news= [NewsObject dbObjectsWhere:condition orderby:nil];
            blocks(news,nil);
        }
    }];
}

-(void)saveNewsList:(NSArray*) newsList AndUniqueIdentifier:(NSString*) identifier{
  
    [NewsObject removeDbObjectsWhere:@"all"];
    for (NewsObject * currNew in newsList) {
        NewsObject *newsObject= [[NewsObject alloc] init];
        newsObject.identifier = identifier;
        newsObject.newsid = currNew.newsid;
        newsObject.title = currNew.title;
        newsObject.commentCount = currNew.commentCount;
        newsObject.author = currNew.author;
        newsObject.authorid = currNew.authorid;
        newsObject.pubDate = currNew.pubDate;
        newsObject.url = currNew.url;
        [newsObject insertToDb];
    }

}
#pragma mark 获取资讯详情
-(void) getnewsDetailWithNewID:(NSString*) Newsid RequestResult:(RequestResultBlocks) blocks{
    NSMutableDictionary *paramters = [NSMutableDictionary dictionaryWithCapacity:1];
    [paramters setValue:Newsid forKey:@"id"];
    NSData *newsData= [[AppCache shareCache] getCachedData:[[NSString stringWithFormat:@"NewsDetail_%@",Newsid] MD5]];
    if ([newsData length]) {
        NSDictionary *dict= [[XMLParser shareInstance] parseData:newsData];
        NSDictionary *news= [XMLParser getDataAtPath:@"oschina.news" fromResultObject:dict];
        blocks(news,nil);
        return;
    }
    [self getPath:kNewsDetailURLString parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"NewsDetail --%@",operation.responseString);
        NSDictionary *dict= [[XMLParser shareInstance] parseData:operation.responseData];
        NSDictionary *news= [XMLParser getDataAtPath:@"oschina.news" fromResultObject:dict];
        [[AppCache shareCache] saveCacheData: operation.responseData forKey:[[NSString stringWithFormat:@"NewsDetail_%@",Newsid] MD5]];
        blocks(news,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        blocks(nil,error);
    }];
}
#pragma mark 获取博客列表信息
-(void)getBloglistWithPageIndex:(NSInteger) pageIndex RequestResult:(RequestResultBlocks) blocks{
    NSMutableDictionary *paramters = [NSMutableDictionary dictionaryWithCapacity:3];
    [paramters setObject:@"latest" forKey:@"type"];
    [paramters setObject:[NSNumber numberWithInteger:pageIndex] forKey:@"pageIndex"];
    [paramters setObject:[NSNumber numberWithInteger:20] forKey:@"pageSize"];
    [self getPath:@"blog_list" parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"blog---%@",operation.responseString);
        NSDictionary *dict= [[XMLParser shareInstance] parseData:operation.responseData];
        NSArray *blogsArray= [XMLParser getDataAtPath:@"oschina.blogs.blog" fromResultObject:dict];
        BlogObject *blogList = [BlogObject entityWithArray:blogsArray];
        blocks(blogList,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        blocks(nil,error);
    }];
}

#pragma mark 获取博客内容
-(void) getblogDetailWithBlogID:(NSString *)blogID RequestResult:(RequestResultBlocks) blocks{

    NSMutableDictionary *paramters = [NSMutableDictionary dictionaryWithCapacity:1];
    [paramters setValue:blogID forKey:@"id"];
    [self getPath:kBlogDetailURLString parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"blogDetail --%@",operation.responseString);
        NSDictionary *dict= [[XMLParser shareInstance] parseData:operation.responseData];
        NSDictionary *blog= [XMLParser getDataAtPath:@"oschina.blog" fromResultObject:dict];
        blocks(blog,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        blocks(nil,error);
    }];

}
#pragma mark 获取资讯详情
-(void) getBlogDetailWithBlogID:(NSString*) Blogid RequestResult:(RequestResultBlocks) blocks{
    NSMutableDictionary *paramters = [NSMutableDictionary dictionaryWithCapacity:1];
    [paramters setObject:Blogid forKey:@"id"];
    [self getPath:kBlogDetailURLString parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"BlogDetail --%@",operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark 获取讨论区列表
-(void) getCommunityListWithType:(NSInteger) currtype PageIndex:(NSInteger) currIndex RequestResult:(RequestResultBlocks) blocks{
     NSMutableDictionary *paramters = [NSMutableDictionary dictionaryWithCapacity:2];
    [paramters setObject:[NSNumber numberWithInteger:currIndex] forKey:@"pageIndex"];
    [paramters setObject:[NSNumber numberWithInteger:currtype] forKey:@"catalog"];
    [self getPath:kCommunityListURLString parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"kCommunityList --%@",operation.responseString);
        NSDictionary *dict= [[XMLParser shareInstance] parseData:operation.responseData];
        NSArray *postsArray= [XMLParser getDataAtPath:@"oschina.posts.post" fromResultObject:dict];
        Post *postsList = [Post entityWithArray:postsArray];
        blocks(postsList,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark 动弹列表
-(void) getTweetListWithID:(NSInteger) tweetID PageIndex:(NSInteger) currIndex RequestResult:(void (^)(id resultDatas,NSInteger tweetCount,NSError *error)) blocks{
    NSMutableDictionary *paramters = [NSMutableDictionary dictionaryWithCapacity:2];
    [paramters setObject:[NSNumber numberWithInteger:currIndex] forKey:@"pageIndex"];
    [paramters setObject:[NSNumber numberWithInteger:tweetID] forKey:@"uid"];
    [self getPath:kTweetListURLString parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"TweetList --%@",operation.responseString);
        NSDictionary *dict= [[XMLParser shareInstance] parseData:operation.responseData];
        NSInteger count =  [[XMLParser getDataAtPath:@"oschina.tweetCount" fromResultObject:dict] integerValue];
        NSArray *postsArray= [XMLParser getDataAtPath:@"oschina.tweets.tweet" fromResultObject:dict];
        Tweet *tweetList = [Tweet entityWithArray:postsArray];
        blocks(tweetList,count,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
@end
