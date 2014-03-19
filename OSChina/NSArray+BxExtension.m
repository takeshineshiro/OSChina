//
//  NSArray+BxExtension.m
//  OSChina
//
//  Created by baxiang on 14-2-11.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "NSArray+BxExtension.h"

@implementation NSArray (BxExtension)


- (id)objectAtIndexOrNil:(NSUInteger)index {
    return (index < [self count]) ? self[index] : nil;
}
@end
