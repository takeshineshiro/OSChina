//
//  News.m
//  OSChina
//
//  Created by baxiang on 14-2-11.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "News.h"

@implementation News

/*
 <news>
 <id>48738</id>
 <title><![CDATA[youyax_v5.6 发布啦，增加子版块功能]]></title>
 <commentCount>4</commentCount>
 <author><![CDATA[youyax新年心语]]></author>
 <authorid>813786</authorid>
 <pubDate>2014-02-11 13:06:30</pubDate>
 <url></url>
 <newstype>
 <type>0</type>
 <authoruid2>813786</authoruid2>
 </newstype>
 </news>
 
 */
-(id)initWithDictionary:(NSDictionary *) dict{
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
     self =[super init];
    if (self) {
        self.newsid = dict[@"id"];
        self.title = dict[@"title"];
        self.commentCount = dict[@"commentCount"];
        self.author = dict[@"author"];
        self.authorid = dict[@"authorid"];
        self.pubDate = [NSDate normalFormatDateFromString:dict[@"pubDate"]];
        self.url = dict[@"url"];
    }
    return self;
}


+(id ) entityWithDict:(NSDictionary *) dict{
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
     News *news=[[News alloc] initWithDictionary:dict];
    return news;
}
+(id) entityWithArray:(NSArray *) array{
    if ( ![array isKindOfClass:[NSArray class]]|| [array count]==0) {
        return nil;
    }
    NSMutableArray *newsList= [NSMutableArray arrayWithCapacity:[array count]];
    for (NSDictionary *newDict in array) {
         News *news=[[News alloc] initWithDictionary:newDict];
        [newsList addObject:news];
    }
    return newsList;
}
@end
