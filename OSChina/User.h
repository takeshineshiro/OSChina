//
//  User.h
//  OSChina
//
//  Created by baxiang on 14-3-29.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "STDbObject.h"

@interface User : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *portrait;
@property (nonatomic,strong) NSDate *jointime;
@property (nonatomic,strong) NSString *fromDistrite;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *devplatform;
@property (nonatomic,strong) NSString *expertise;
@property (nonatomic,strong) NSString *favoritecount;
@property (nonatomic,strong) NSString *fanscount;
@property (nonatomic,strong) NSString *followerscount;
@end
