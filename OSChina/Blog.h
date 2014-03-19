//
//  Blog.h
//  OSChina
//
//  Created by baxiang on 14-2-12.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 <blog>
 <id>199178</id>
 <title><![CDATA[面试题]]></title>
 <url><![CDATA[http://my.oschina.net/u/1248325/blog/199178]]></url>
 <pubDate>2014-02-12 18:13:12</pubDate>
 <authoruid>1248325</authoruid>
 <authorname><![CDATA[迪1迪2]]></authorname>
 <commentCount>0</commentCount>
 <documentType>1</documentType>
 </blog>
 */
@interface Blog : NSObject
@property (nonatomic, strong) NSString *blogID;
@property (nonatomic, strong) NSString *blogTitle;
@property (nonatomic, strong) NSString *blogUrl;
@property (nonatomic, strong) NSDate * pubDate;
@property (nonatomic, strong) NSString *authoruid;
@property (nonatomic, strong) NSString *authorname;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *documentType;

+(id) entityWithArray:(NSArray *) array;
@end
