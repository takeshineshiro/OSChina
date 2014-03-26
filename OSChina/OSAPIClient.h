//
//  OSAPIClient.h
//  OSChina
//
//  Created by baxiang on 14-1-23.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "AFHTTPClient.h"


typedef void(^RequestResultBlocks)(id  resultDatas,NSError *error);

@interface OSAPIClient : AFHTTPClient

+(OSAPIClient*) shareClient;
-(void)getNewslistWithPageIndex:(NSInteger) pageIndex RequestResult:(RequestResultBlocks) blocks;
-(void)getBloglistWithPageIndex:(NSInteger) pageIndex RequestResult:(RequestResultBlocks) blocks;
-(void) getnewsDetailWithNewID:(NSString*) Newsid RequestResult:(RequestResultBlocks) blocks;
-(void) getCommunityListWithType:(NSInteger) currtype PageIndex:(NSInteger) currIndex RequestResult:(RequestResultBlocks) blocks;
-(void) getblogDetailWithBlogID:(NSString *)blogID RequestResult:(RequestResultBlocks) blocks;
-(void) getTweetListWithID:(NSInteger) tweetID PageIndex:(NSInteger) currIndex RequestResult:
(void (^)(id resultDatas,NSInteger tweetCount,NSError *error)) blocks;
-(void) userLoginName:(NSString*) userName passWord:(NSString*) password RequestResult:(RequestResultBlocks) blocks;
@end
