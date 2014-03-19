//
//  AppCache.m
//  OSChina
//
//  Created by baxiang on 14-2-16.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "AppCache.h"

static NSString * kDefaultCacheName = @"OSChina_Cache";
@interface AppCache()
@property (nonatomic, strong) NSMutableDictionary *memoryCache;
@property (nonatomic, strong) dispatch_queue_t  currCacheQueue;
@end


@implementation AppCache


-(id) init{
    self = [super init];
    if (self) {
        NSString *cacheDirectory = [self cacheDirectoryName];
        self.currCacheQueue = dispatch_queue_create("com.oschina", DISPATCH_QUEUE_SERIAL);
        self.memoryCache = [NSMutableDictionary dictionary];
        BOOL isDirectory = YES;
        BOOL folderExists = [[NSFileManager defaultManager] fileExistsAtPath:cacheDirectory isDirectory:&isDirectory] && isDirectory;
        if (!folderExists){
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:cacheDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        }
        [self initObserver];
    }
    return self;
}

+(AppCache*) shareCache{
    static AppCache *currCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currCache= [[AppCache alloc] init];
    });
    return currCache;
}
-(void) initObserver{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCache)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCache)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCache)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCache)
                                                 name:KPopCurrentView
                                               object:nil];
}
//  默认的缓存路径
-(NSString*) cacheDirectoryName {
    
    static NSString *cacheDirectoryName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
        cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:kDefaultCacheName];
    });
    return cacheDirectoryName;
}

-(void) saveCache {
    
    for(NSString *cacheKey in [self.memoryCache allKeys])
    {
        NSString *filePath = [[self cacheDirectoryName] stringByAppendingPathComponent:cacheKey];
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        }
        [(self.memoryCache)[cacheKey] writeToFile:filePath atomically:YES];
    }
    [self.memoryCache removeAllObjects];
}

-(void) saveCacheData:(NSData*) data forKey:(NSString*) cacheDataKey
{
    dispatch_async(self.currCacheQueue, ^{
        (self.memoryCache)[cacheDataKey] = data;
    });
}

-(NSData*) getCachedData:(NSString*) key {
    
    NSData *cachedData = (self.memoryCache)[key];
    if(cachedData) return cachedData;
    
    NSString *filePath = [[self cacheDirectoryName] stringByAppendingPathComponent:key];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        cachedData = [NSData dataWithContentsOfFile:filePath];
        [self saveCacheData:cachedData forKey:key]; // bring it back to the in-memory cache
        return cachedData;
    }
    
    return nil;
}

@end
