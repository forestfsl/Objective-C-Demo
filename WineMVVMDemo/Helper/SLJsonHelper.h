//
//  SLJsonHelper.h
//  WineMVVMDemo
//
//  Created by songlin on 28/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLJsonHelper : NSObject

/**
 * 将Json字符串转为Dictionary或者Array对象
 */
+ (id)toJsonObject:(NSString *)string error:(NSError **)error;

+ (id)toJsonObject:(NSString *)string;

+ (id)fromResource:(NSString *)resouce ofType:(NSString *)type;

/**
 * 将对象转换为Json字符串
 */
+ (NSString *)toJsonString:(id)object error:(NSError **)error;

+ (NSString *)toJsonString:(id)object;

/**
 * 将对象转换为Json字符串
 */
+ (NSString *)toJsonString:(id)object prettyPrint:(BOOL)pretty error:(NSError **)error;

+ (NSString *)toJsonString:(id)object prettyPrint:(BOOL)pretty;

@end
