//
//  NewsDetail.m
//  OSChina
//
//  Created by baxiang on 14-2-14.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "NewsDetail.h"

@implementation NewsDetail

-(id) initWithDictionary:(NSDictionary*) dict{
   self = [super init];
    if (self) {
        self.newsID = [dict stringForKey:@"id"];
        self.newsTitle = [dict stringForKey:@"title"];
        self.newsURL = [dict stringForKey:@"url"];
        self.newsBody  = [dict stringForKey:@"body"];
        self.newsCommentCount = [dict stringForKey:@"commentCount"];
        self.newsAuthor = [dict stringForKey:@"author"];
        self.newsAuthorid = [dict stringForKey:@"authorid"];
        self.newsPubDate =[NSDate  normalFormatDateFromString:[dict stringForKey:@"pubDate"]];
        self.SoftwareLink = [dict stringForKey:@"softwarelink"];
        self.softwareName = [dict stringForKey:@"softwarename"];
        self.Newsfavorite = [dict stringForKey:@"favorite"];
    }
    return self;
}


@end
