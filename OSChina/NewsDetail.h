//
//  NewsDetail.h
//  OSChina
//
//  Created by baxiang on 14-2-14.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>

/*资讯详情*/
@interface NewsDetail : NSObject

@property (nonatomic,strong)  NSString* newsID;
@property (nonatomic,strong)  NSString* newsTitle;
@property (nonatomic,strong)  NSString* newsURL;
@property (nonatomic,strong)  NSString* newsBody;
@property (nonatomic,strong)  NSString* newsCommentCount;
@property (nonatomic,strong)  NSString* newsAuthor;
@property (nonatomic,strong)  NSString* newsAuthorid;
@property (nonatomic,strong)  NSDate* newsPubDate;
@property (nonatomic,strong)  NSString* SoftwareLink;
@property (nonatomic,strong)  NSString* softwareName;
@property (nonatomic,strong)  NSString* Newsfavorite;
-(id) initWithDictionary:(NSDictionary*) dict;
@end
