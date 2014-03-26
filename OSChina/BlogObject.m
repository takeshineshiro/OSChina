//
//  BlogObject.m
//  OSChina
//
//  Created by Baxiang on 14-3-26.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "BlogObject.h"

@implementation BlogObject
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
        BlogObject *blog=[[BlogObject alloc] initWithDictionary:newDict];
        [blogList addObject:blog];
    }
    return blogList;
}
@end