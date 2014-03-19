//
//  Post.m
//  OSChina
//
//  Created by baxiang on 14-2-16.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "Post.h"

@implementation Post

/*
 <post>
 <id>143732</id>
 <portrait>http://static.oschina.net/uploads/user/689/1379730_50.jpg?t=1388366539000</portrait>
 <author><![CDATA[lazyphp]]></author>
 <authorid>1379730</authorid>
 <title><![CDATA[[已解决]为什么ubuntu下,chrome非要命令行才可以打开?]]></title>
 <answerCount>3</answerCount>
 <viewCount>123</viewCount>
 <pubDate>2014-02-16 20:08:08</pubDate>
 <answer>
 <name><![CDATA[eechen]]></name>
 <time>2014-02-16 22:18:54</time>
 </answer>
 </post>
 <post>
 */
-(id)initWithDictionary:(NSDictionary *) dict{
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self =[super init];
    if (self) {
        self.postID = dict[@"id"];
        self.portrait = [dict stringForKey:@"portrait"];
        self.author = dict[@"author"];
        self.authorid = dict[@"authorid"];
        self.title = dict[@"title"];
        self.answerCount = dict[@"answerCount"];
        self.viewCount = dict[@"viewCount"];
        self.pubDate = [NSDate normalFormatDateFromString:dict[@"pubDate"]];
    }
    return self;
}

+(id) entityWithArray:(NSArray *) array{
    if ( ![array isKindOfClass:[NSArray class]]|| [array count]==0) {
        return nil;
    }
    NSMutableArray *postsList= [NSMutableArray arrayWithCapacity:[array count]];
    for (NSDictionary *newDict in array) {
        Post *post=[[Post alloc] initWithDictionary:newDict];
        [postsList addObject:post];
    }
    return postsList;
}
@end
