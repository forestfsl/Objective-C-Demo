//
//  SLSiftModel.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLSiftModel.h"

@implementation SLSiftModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        for (NSString *key in [dic allKeys])
        {
            [self setValue:dic[key] forKey:key];
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@",key);
}

@end
