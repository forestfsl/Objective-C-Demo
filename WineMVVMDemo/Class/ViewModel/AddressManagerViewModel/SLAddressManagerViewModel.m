//
//  SLAddressManagerViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLAddressManagerViewModel.h"
#import "SLAddressViewModel.h"

@implementation SLAddressManagerViewModel
- (instancetype)initWithService:(id<SLViewModelServices>)service params:(NSDictionary *)params
{
    self = [super initWithService:service params:params];
    if (self)
    {
        [self initViewModel];
    }
    return self;
}

- (void)initViewModel
{
    @weakify(self);
    self.addAddressCommand      = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        SLAddressViewModel *viewModel = [[SLAddressViewModel alloc]initWithService:self.services params:@{@"title":@"新建地址"}];
        self.navImpl.className = @"SLAddressVC";
        [self.navImpl pushViewModel:viewModel animated:YES];
        
        
        return [RACSignal empty];
    }];
    
    self.editAddress            = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        SLAddressViewModel *viewModel = [[SLAddressViewModel alloc]initWithService:self.services params:@{@"title":@"新建地址"}];
        viewModel.address = input;
        self.navImpl.className = @"SLAddressVC";
        [self.navImpl pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];
    
    self.deleteAddress          = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [CURRENT_USER.address removeObject:input];
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"删"];
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
    
    self.cellClickCommand       = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        NSLog(@"13");
        if (self.isShoppingCar)
        {
            RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                [self.navImpl popViewControllerWithAnimation:YES];
                return nil;
            }];
            return signal;
        }
        else
        {
            //            设置本address为默认
            if (input == CURRENT_USER.defaultAddress)
            {
                //                已经是默认
                SHOW_ERROE(@"已经是默认地址");
                DISMISS_SVP(1.2);
            }
            else
            {
                CURRENT_USER.defaultAddress = input;
                SHOW_SUCCESS(@"设置成功");
                DISMISS_SVP(1.2);
            }
        }
        return [RACSignal empty];
    }];
}

@end
