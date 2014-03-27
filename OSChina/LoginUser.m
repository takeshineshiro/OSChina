//
//  LoginUser.m
//  OSChina
//
//  Created by baxiang on 14-3-28.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "LoginUser.h"

@implementation LoginUser


-(id)initWithDictionary:(NSDictionary *) dict{
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self =[super init];
    if (self) {
        self.name = dict[@"name"];
        self.portrait = dict[@"portrait"];
        self.jointime = dict[@"jointime"];
        self. gender= [dict[@"gender"] integerValue];
        self.from = dict[@"from"];
        self.devplatform = dict[@"devplatform"];
        self.expertise = dict [@"expertise"];
        self.followerscount = [dict [@"favoritecount"] integerValue];
        self.fanscount = [dict [@"fanscount"] integerValue];
        self.followerscount = [dict [@"followerscount"] integerValue];
        [self insertToDb];
    }
    return self;
}

@end
