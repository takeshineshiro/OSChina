//
//  BlogDetail.h
//  OSChina
//
//  Created by baxiang on 14-2-19.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogDetail : NSObject

@property (nonatomic,strong)  NSString* BlogID;
@property (nonatomic,strong)  NSString* BlogTitle;
@property (nonatomic,strong)  NSString* BlogWhere;
@property (nonatomic,strong)  NSString* BlogBody;
@property (nonatomic,strong)  NSString* BlogCommentCount;
@property (nonatomic,strong)  NSString* BlogAuthor;
@property (nonatomic,strong)  NSString* BlogAuthorid;
@property (nonatomic,strong)  NSDate*   BlogPubDate;
@property (nonatomic,strong)  NSString* documentType;
@property (nonatomic,strong)  NSString* blogfavorite;
-(id) initWithDictionary:(NSDictionary*) dict;
@end
