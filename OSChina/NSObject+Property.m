//
//  NSObject+Property.m
//  OSChina
//
//  Created by baxiang on 14-3-30.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "NSObject+Property.h"

@implementation NSObject (Property)


-(NSArray*) getPropertyList:(Class) class{
     unsigned  count ;
    objc_property_t *properties= class_copyPropertyList(class, &count);
    NSMutableArray *propertyArray= [NSMutableArray arrayWithCapacity:count];
    for (int i =0 ; i<count; i++) {
    const  char *propertyName=  property_getName(properties[i]);
        [propertyArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(properties);
    return propertyArray;
}
@end
