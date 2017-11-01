//
//  SLBaseViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLViewModelServices.h"
#import "SLViewModelNavigationIml.h"
#import "SLViewModelServices.h"

@interface SLBaseViewModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy, readonly) NSDictionary *params;

@property (nonatomic, strong) SLViewModelNavigationIml *navImpl;

@property (nonatomic, strong, readonly) id<SLViewModelServices>services;

- (instancetype)initWithService:(id<SLViewModelServices>)service params:(NSDictionary *)params;

/**
 *  判断是否登录
 *  @param  goGoLogin 如果没有登录，是否跳转到登录页面
 */
- (BOOL)judgeWhetherLogin:(BOOL)goGoLogin;
@end
