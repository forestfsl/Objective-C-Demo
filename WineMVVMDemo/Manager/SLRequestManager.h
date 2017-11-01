//
//  SLRequestManager.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//




@end
#import <Foundation/Foundation.h>

@interface SLRequestManager : NSObject

//本地数据（array）
+ (RACSignal *)postArrayDataWithURL:(NSString *)urlString parameter:(NSDictionary *)parameter;
//本地数据（dic)
+ (RACSignal *)postDicDataWithURL:(NSString *)urlString parameter:(NSDictionary *)parameter;

+ (RACSignal *)getWithURL:(NSString *)urlString parameter:(NSDictionary *)parameter;

+ (RACSignal *)postWithURL:(NSString *)urlString parameter:(NSDictionary *)parameter;


@end
