//
//  NSString+BxExtension.h
//  OSChina
//
//  Created by baxiang on 14-2-12.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BxExtension)


-(NSString *)MD5;
-(NSString *)sha1;
-(NSString *)reverse;
-(NSString *)URLEncode;
-(NSString *)URLDecode;
-(NSString *)stringByStrippingWhitespace;
-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
-(NSString *)CapitalizeFirst:(NSString *)source;
-(NSString *)UnderscoresToCamelCase:(NSString*)underscores;
-(NSString *)CamelCaseToUnderscores:(NSString *)input;

-(NSUInteger)countWords;


-(BOOL)contains:(NSString *)string;
-(BOOL)isBlank;
@end
