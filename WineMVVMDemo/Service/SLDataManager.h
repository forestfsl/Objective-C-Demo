//
//  SLDataManager.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLDataManager : NSObject

/**
 *  保存用户数据
 */
+ (void)saveUserData;

/**
 *  读取用户数据
 */
+ (void)readUserData;

/**
 *  删除用户数据
 */
+ (void)removeUserData;

@end
