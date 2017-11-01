//
//  SLGood.m
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLGood.h"
#import <objc/runtime.h>

@implementation SLGood

-(instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        for (NSString *key in [dic allKeys]) {
            [self setValue:dic[key] forKey:key];
        }
    }
    return self;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    unsigned int count = 0;
   objc_property_t *propertyList = class_copyPropertyList([SLGood class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t pro = propertyList[i];
        const char *name = property_getName(pro);
        NSString *key = [NSString stringWithUTF8String:name];
        if ([aDecoder decodeObjectForKey:key]) {
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t pro = propertyList[i];
        const char *name = property_getName(pro);
        NSString *key = [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    [aCoder encodeObject:@(NO) forKey:@"w_isSelected"];
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"title:%@--isSelected:%d---num:%ld--price:%.2f",self.title,self.w_isSelected,self.num,self.price];
}
@end
