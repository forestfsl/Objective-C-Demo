//
//  SLPaySuccessViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLPaySuccessViewModel.h"
#import "SLOrderViewModel.h"

@implementation SLPaySuccessViewModel

- (instancetype)initWithService:(id<SLViewModelServices>)service params:(NSDictionary *)params
{
    self = [super initWithService:self.services params:params];
    if (self)
    {
        [self initViewModel];
    }
    return self;
}

- (void)initViewModel
{
    self.orderCommand       = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        SLOrderViewModel *viewModel = [[SLOrderViewModel alloc]initWithService:self.services params:@{@"title":@"全部订单"}];
        viewModel.orderType = 0;
        self.navImpl.className = @"WTKOrderVC";
        [self.navImpl pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];
    
    self.goHomeCommand      = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        [self.navImpl popToRootViewModelWithAnimation:YES];
        return [RACSignal empty];
    }];
}

@end
