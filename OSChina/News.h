//
//  News.h
//  OSChina
//
//  Created by baxiang on 14-2-11.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 <news>
 <id>48738</id>
 <title><![CDATA[youyax_v5.6 发布啦，增加子版块功能]]></title>
 <commentCount>4</commentCount>
 <author><![CDATA[youyax新年心语]]></author>
 <authorid>813786</authorid>
 <pubDate>2014-02-11 13:06:30</pubDate>
 <url></url>
 <newstype>
 <type>0</type>
 <authoruid2>813786</authoruid2>
 </newstype>
 </news>
 
 */
@interface News : NSObject

@property (nonatomic,strong) NSString *newsid;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *commentCount;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *authorid;
@property (nonatomic,strong) NSDate *pubDate;
@property (nonatomic,strong) NSString *url;
+(id) entityWithDict:(NSDictionary *) dict;
+(id) entityWithArray:(NSArray *) array;
@end
