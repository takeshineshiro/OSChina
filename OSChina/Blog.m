//
//  Blog.m
//  OSChina
//
//  Created by baxiang on 14-2-12.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "Blog.h"
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
@implementation Blog
-(id)initWithDictionary:(NSDictionary *) dict{
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self =[super init];
    if (self) {
        self.blogID = [dict stringForKey:@"id"];
        self.blogTitle = [dict stringForKey:@"title"];
        self.blogUrl = [dict stringForKey:@"url"];
        self.authoruid = [dict stringForKey:@"authoruid"];
        self.authorname = [dict stringForKey:@"authorname"];
        self.commentCount = [dict stringForKey:@"commentCount"];
        self.documentType = [dict stringForKey:@"documentType"];
        self.pubDate =  [NSDate normalFormatDateFromString:[dict stringForKey:@"pubDate"]];
    }
    return self;
}

+(id) entityWithArray:(NSArray *) array{
    if ( ![array isKindOfClass:[NSArray class]]|| [array count]==0) {
        return nil;
    }
    NSMutableArray *blogList= [NSMutableArray arrayWithCapacity:[array count]];
    for (NSDictionary *newDict in array) {
        Blog *blog=[[Blog alloc] initWithDictionary:newDict];
        [blogList addObject:blog];
    }
    return blogList;
}
@end
