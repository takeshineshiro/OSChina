//
//  DBManager.h
//  OSChina
//
//  Created by baxiang on 14-3-29.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

#define dataBasePath [[(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) lastObject]stringByAppendingPathComponent:dataBaseName]
#define dataBaseName @"dataBase.sqlite"

@interface DBManager : NSObject

@end
