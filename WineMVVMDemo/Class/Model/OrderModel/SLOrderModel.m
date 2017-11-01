//
//  SLOrderModel.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLOrderModel.h"
#import "SLOrderDetailModel.h"

@implementation SLOrderModel

- (instancetype)initWithDic:(NSDictionary *)aDic
{
    self = [super init];
    if (self)
    {
        for (NSString *key in [aDic allKeys])
        {
            if ([key isEqualToString:@"ordergoods"])
            {
                NSArray *array = aDic[@"ordergoods"];
                NSMutableArray *mArray = @[].mutableCopy;
                for (NSDictionary *aDic in array)
                {
                    SLOrderDetailModel *model = [[SLOrderDetailModel alloc]init];
                    [model setValuesForKeysWithDictionary:aDic];
                    [mArray addObject:model];
                }
                self.ordergoods = mArray;
                
            }
            else
            {
                [self setValue:aDic[key] forKey:key];
            }
            
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
