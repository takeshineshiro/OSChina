//
//  BlogDetail.m
//  OSChina
//
//  Created by baxiang on 14-2-19.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "BlogDetail.h"

@implementation BlogDetail

-(id) initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if (self) {
        self.blogID = [dict stringForKey:@"id"];
        self.blogTitle = [dict stringForKey:@"title"];
        self.blogWhere = [dict stringForKey:@"where"];
        self.blogBody  = [dict stringForKey:@"body"];
        self.blogCommentCount = [dict stringForKey:@"commentCount"];
        self.blogAuthor = [dict stringForKey:@"author"];
        self.blogAuthorid = [dict stringForKey:@"authorid"];
        self.blogPubDate =[NSDate  normalFormatDateFromString:[dict stringForKey:@"pubDate"]];
        self.documentType = [dict stringForKey:@"documentType"];
        self.Blogfavorite = [dict stringForKey:@"favorite"];
    }
    return self;
}

@end
