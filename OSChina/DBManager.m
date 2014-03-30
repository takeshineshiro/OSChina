//
//  DBManager.m
//  OSChina
//
//  Created by baxiang on 14-3-29.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//
/**
 *  数据库管理类
 */
#import "DBManager.h"



#define LINEINFO_CREATE_TABLE_SQL \
@"CREATE TABLE lineInfo (                       \
lineId text,                                \
lineName text,                              \
edgeStation_1 text,                         \
edgeStation_2 text,                         \
identifier text,                            \
identifier_1_favorite integer,              \
identifier_2_favorite integer,              \
identifier_1_schedule text,                 \
identifier_2_schedule text                  \
)"


static FMDatabase *shareDataBase = nil;
@implementation DBManager

/**
 *  创建数据库
 *
 *  @return 数据库
 */
+ (FMDatabase *)createDataBase {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareDataBase = [FMDatabase databaseWithPath:dataBasePath];
    });
    return shareDataBase;
}
/**
 判断数据库中表是否存在
 **/
+ (BOOL) isTableExist:(NSString *)tableName
{
    FMResultSet *rs = [shareDataBase executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"%@ isOK %d", tableName,count);
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}
+ (BOOL)createTable {
    
            shareDataBase = [DBManager createDataBase];
            if ([shareDataBase open]) {
                if (![DBManager isTableExist:@"message_table"]) {
                    NSString *sql = @"CREATE TABLE \"message_table\" (\"message_id\" TEXT PRIMARY KEY  NOT NULL  check(typeof(\"message_id\") = 'text') , \"att\" BLOB)";
                    NSLog(@"no Medicine ");
                    [shareDataBase executeUpdate:sql];
                }
                [shareDataBase close];
            }
    
    
    
    return YES;
}
-(void) createUserInfoTable{
    NSString *sql =@"CREATE TABLE IF NOT EXISTS User_Info(    \
    lineId text,                                \
    lineName text,                              \
    edgeStation_1 text,                         \
    edgeStation_2 text,                         \
    identifier text,                            \
    identifier_1_favorite integer,              \
    identifier_2_favorite integer,              \
    identifier_1_schedule text,                 \
    identifier_2_schedule text                  \
    )";





}
/**
 关闭数据库
 **/
+ (void)closeDataBase {
    if(![shareDataBase close]) {
        NSLog(@"数据库关闭异常，请检查");
        return;
    }
}

//+ (BOOL) saveOrUpdataMessage:(Message*)message
//{
//    BOOL isOk = NO;
//    shareDataBase = [DBManager createDataBase];
//    if ([shareDataBase open]) {
//        isOk = [shareDataBase executeUpdate:
//                @"INSERT INTO \"message_table\" (\"message_id\",\"att\") VALUES(?,?)",message.messageId,[NSKeyedArchiver archivedDataWithRootObject:message.att]];
//        [shareDataBase close];
//    }
//    return isOk;
//}
//
//+ (Message *) selectMessageByMessageId:(NSString*)messageId
//{
//    Message *m = nil;
//    shareDataBase = [DBManager createDataBase];
//    if ([shareDataBase open]) {
//        FMResultSet *s = [shareDataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM \"message_table\" WHERE \"message_id\" = '%@'",messageId]];
//        if ([s next]) {
//            m = [[Message alloc] init];
//            m.messageId = [s stringForColumn:@"message_id"];
//            m.att = [NSKeyedUnarchiver unarchiveObjectWithData:[s dataForColumn:@"att"]];
//        }
//        [shareDataBase close];
//    }
//    return m;
//}



@end
