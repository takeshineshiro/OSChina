//
//  NewsObject.m
//  OSChina
//
//  Created by baxiang on 14-3-19.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "NewsObject.h"

@implementation NewsObject


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
+(id) entityWithArray:(NSArray *) array{
    if ( ![array isKindOfClass:[NSArray class]]|| [array count]==0) {
        return nil;
    }
    NSMutableArray *newsList= [NSMutableArray arrayWithCapacity:[array count]];
    for (NSDictionary *newDict in array) {
        NewsObject *news=[[NewsObject alloc] initWithDictionary:newDict];
        [newsList addObject:news];
    }
    return newsList;
}

@end
