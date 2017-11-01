//
//  SLNetWorkManager.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLNetWorkManager : NSObject

@property(nonatomic,assign)BOOL isNetReachable;

+ (instancetype)shareInatance;

- (void)initNetWork;

@end
