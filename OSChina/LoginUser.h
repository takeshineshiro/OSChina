//
//  LoginUser.h
//  OSChina
//
//  Created by baxiang on 14-3-28.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "STDbObject.h"
//#import "LKDBHelper.h"
/*<name><![CDATA[羊羽1989]]></name>
<portrait><![CDATA[http://static.oschina.net/uploads/user/430/860718_100.jpg?t=1395854105000]]></portrait>
                   <jointime>2012-11-01 09:51:49</jointime>
                   <gender>1</gender>
                   <from><![CDATA[湖北 武汉]]></from>
                   <devplatform><![CDATA[<无>]]></devplatform>
                   <expertise><![CDATA[<无>]]></expertise>
                   <favoritecount>2</favoritecount>
                   <fanscount>0</fanscount>
                   <followerscount>0</followerscount>
*/
@interface LoginUser : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *portrait;
@property (nonatomic,strong) NSString *jointime;
@property (nonatomic,strong) NSString *fromDistrict;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *devplatform;
@property (nonatomic,strong) NSString *expertise;
@property (nonatomic,strong) NSString *favoritecount;
@property (nonatomic,strong) NSString *fanscount;
@property (nonatomic,strong) NSString *followerscount;

-(id)initWithDictionary:(NSDictionary *) dict;
//-(void) save;
@end
