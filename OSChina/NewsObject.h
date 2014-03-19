//
//  NewsObject.h
//  OSChina
//
//  Created by baxiang on 14-3-19.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "STDbObject.h"

@interface NewsObject : STDbObject

@property (nonatomic,strong) NSString *identifier;
@property (nonatomic,strong) NSString *newsid;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *commentCount;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *authorid;
@property (nonatomic,strong) NSDate *pubDate;
@property (nonatomic,strong) NSString *url;

+(id) entityWithArray:(NSArray *) array;
@end
