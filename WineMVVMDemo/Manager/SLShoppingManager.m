//
//  SLShoppingManager.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLShoppingManager.h"
#import <objc/runtime.h>
#import "SLGood.h"

@implementation SLShoppingManager

+ (instancetype)manager
{
    static SLShoppingManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SLShoppingManager alloc]init];
        manager.goodsDic = [NSMutableDictionary dictionary];
    });
    return manager;
}


- (NSMutableDictionary *)goodsDic
{
    //    NSInteger a = [self.changed integerValue];
    //    if (a > 10000)
    //    {
    //        a = 0;
    //    }
    //    a++;
    if (!self.flag)
    {
        self.changed = [NSString stringWithFormat:@"%d",15];
    }
    return _goodsDic;
}

- (void)refreshGoods
{
    NSArray *goodArray          = [self.goodsDic allValues];
    [self.goodsDic removeAllObjects];
    [goodArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SLGood *good = obj;
        if (!good.w_isSelected)
        {
            self.goodsDic[good.id] = good;
        }
        else
        {
            CURRENT_USER.bageValue -= good.num;
        }
        if (idx == goodArray.count - 1)
        {
            [SLDataManager saveUserData];
        }
    }];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    unsigned int count = 0;
    
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++)
    {
        objc_property_t pro = propertyList[i];
        const char *name = property_getName(pro);
        NSString *key = [NSString stringWithUTF8String:name];
        if ([aDecoder decodeObjectForKey:key])
        {
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    
    for (int i = 0 ; i < count; i++)
    {
        objc_property_t pro = propertyList[i];
        const char *name   = property_getName(pro);
        NSString *key = [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}


@end
