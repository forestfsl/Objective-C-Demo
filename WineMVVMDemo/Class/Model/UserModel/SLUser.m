//
//  SLUser.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLUser.h"
#import <objc/runtime.h>

#define userTag @"user"

@implementation SLUser

+ (instancetype)currentUser {
    static SLUser *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[SLUser alloc]init];
        user.bageValue  = 0;
        user.bid        = @"56c45924c2fb4e2050000022";
        user.isSound    = YES;
        user.isShake    = YES;
        user.nickName   = @"昵称";
        user.sex        = YES;
        user.birthDay   = @"输入后不可修改";
        user.address    = @[].mutableCopy;
        user.phoneNum   = @"";
        
    });
    return user;
}

- (BOOL)isLogin
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:userTag])
    {
        return YES;
    }
    return  NO;
}

- (SLAddress *)defaultAddress
{
    if (!_defaultAddress)
    {
        if (self.address.count >= 1)
        {
            _defaultAddress = self.address[0];
        }
        else
        {
            _defaultAddress = [[SLAddress alloc]init];
            _defaultAddress.name = CURRENT_USER.nickName;
            _defaultAddress.phone = CURRENT_USER.phoneNum;
            _defaultAddress.address = @"";
        }
    }
    return _defaultAddress;
}

//实现归档解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    
    for (int i = 0 ; i < count; i++)
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
    for (int i = 0 ; i < count; i ++)
    {
        objc_property_t pro = propertyList[i];
        const char *name = property_getName(pro);
        NSString *key  = [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}
@end
