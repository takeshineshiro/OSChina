//
//  BlogObject.h
//  OSChina
//
//  Created by Baxiang on 14-3-26.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "STDbObject.h"

@interface BlogObject : STDbObject

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
