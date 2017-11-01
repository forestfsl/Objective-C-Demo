//
//  SLBaseViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"
#import "SLLoginViewModel.h"

@interface SLBaseViewModel()
@property (nonatomic, strong, readwrite) id <SLViewModelServices>services;
@property (nonatomic, copy, readwrite) NSDictionary *params;

@end

@implementation SLBaseViewModel

- (instancetype)initWithService:(id<SLViewModelServices>)service params:(NSDictionary *)params {
    if (self = [super init]) {
        self.title = params[@"title"];
        self.params = params;
        self.services = service;
    }
    return self;
}


- (BOOL)judgeWhetherLogin:(BOOL)goLogin
{
    if ([SLUser currentUser].isLogin)
    {
        return YES;
    }
    if (goLogin)
    {
        SLLoginViewModel *viewModel    = [[SLLoginViewModel alloc]initWithService:self.services params:@{@"title":@"登录"}];
        self.navImpl.className         = @"WTKLoginVC";
        [self.navImpl pushViewModel:viewModel animated:YES];
    }
    
    //    GOlOGIN
    
    return NO;
    
}
@end
