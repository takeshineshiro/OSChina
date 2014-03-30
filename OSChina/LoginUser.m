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
        self. gender= dict[@"gender"] ;
        self.fromDistrict = dict[@"from"];
        self.devplatform = dict[@"devplatform"];
        self.expertise = dict [@"expertise"];
        self.favoritecount = dict [@"favoritecount"];
        self.fanscount = dict [@"fanscount"] ;
        self.followerscount = dict [@"followerscount"];
    }
    
    return self;
}

//+(NSDictionary *)getTableMapping
//{
//    return nil;
//    //    return @{@"name":LKSQL_Mapping_Inherit,
//    //             @"MyAge":@"age",
//    //             @"img":LKSQL_Mapping_Inherit,
//    //             @"MyDate":@"date",
//    //
//    //             // version 2 after add
//    //             @"color":LKSQL_Mapping_Inherit,
//    //
//    //             //version 3 after add
//    //             @"address":LKSQL_Mapping_UserCalculate,
//    //             @"error":LKSQL_Mapping_Inherit
//    //             };
//}
//
//+(NSString *)getPrimaryKey
//{
//    return @"name";
//}
//+(NSString *)getTableName
//{
//    return @"userInfo";
//}
//+(int)getTableVersion
//{
//    return 1;
//}
//+(void)initialize{
//   
//    [[self getUsingLKDBHelper] createTableWithModelClass:self];
//
//}

@end
