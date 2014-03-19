//
//  Post.h
//  OSChina
//
//  Created by baxiang on 14-2-16.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Post : NSObject

@property (nonatomic ,strong) NSString* postID;
@property (nonatomic ,strong) NSString* portrait;
@property (nonatomic ,strong) NSString* author;
@property (nonatomic ,strong) NSString* authorid;
@property (nonatomic ,strong) NSString* title;
@property (nonatomic ,strong) NSString* answerCount;
@property (nonatomic ,strong) NSString* viewCount;
@property (nonatomic ,strong) NSDate* pubDate;

+(id) entityWithArray:(NSArray *) array;
@end
