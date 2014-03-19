//
//  Tweet.m
//  OSChina
//
//  Created by baxiang on 14-2-20.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet


-(id)initWithDictionary:(NSDictionary *) dict{
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self =[super init];
    if (self) {
        self.tweetID = dict[@"id"];
        self.portrait = [dict stringForKey:@"portrait"];
        self.author = dict[@"author"];
        self.authorid = dict[@"authorid"];
        self.body = dict[@"body"];
        self.appclient = dict[@"appclient"];
        self.commentCount = dict[@"commentCount"];
        self.body = dict[@"body"];
        self.pubDate = [NSDate normalFormatDateFromString:dict[@"pubDate"]];
        self.imgSmall = dict[@"imgSmall"];
        self.imgBig = dict[@"imgSmall"];
    }
    return self;
}

+(id) entityWithArray:(NSArray *) array{
    if ( ![array isKindOfClass:[NSArray class]]|| [array count]==0) {
        return nil;
    }
    NSMutableArray *tweetList= [NSMutableArray arrayWithCapacity:[array count]];
    for (NSDictionary *dict in array) {
        Tweet *tweet=[[Tweet alloc] initWithDictionary:dict];
        [tweetList addObject:tweet];
    }
    return tweetList;
}

@end
