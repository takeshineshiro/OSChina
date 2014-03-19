//
//  AppCache.h
//  OSChina
//
//  Created by baxiang on 14-2-16.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>

// 缓存工具类
@interface AppCache : NSObject

+(AppCache*) shareCache;
-(void) saveCacheData:(NSData*) data forKey:(NSString*) cacheDataKey;
-(NSData*) getCachedData:(NSString*) key;
@end
