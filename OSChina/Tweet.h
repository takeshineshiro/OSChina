//
//  Tweet.h
//  OSChina
//
//  Created by baxiang on 14-2-20.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
<id>3166637</id>
<portrait>http://static.oschina.net/uploads/user/40/81981_50.jpg?t=1368535370000</portrait>
<author><![CDATA[方小葱]]></author>
<authorid>81981</authorid>
<body><![CDATA[目前而言智能家装有市场么?]]></body>
<appclient>1</appclient>
<commentCount>0</commentCount>
<pubDate>2014-02-19 23:55:26</pubDate>
<imgSmall></imgSmall>
<imgBig></imgBig>
 */
@interface Tweet : NSObject
@property (nonatomic, strong) NSString *tweetID;
@property (nonatomic, strong) NSString *portrait;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *authorid;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *appclient;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSDate   *pubDate;
@property (nonatomic, strong) NSString *imgSmall;
@property (nonatomic, strong) NSString *imgBig;

+(id) entityWithArray:(NSArray *) array;
@end
