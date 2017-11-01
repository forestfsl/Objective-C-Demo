//
//  SLRecommendViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLRecommendViewModel.h"

@implementation SLRecommendViewModel

- (instancetype)initWithService:(id<SLViewModelServices>)service params:(NSDictionary *)params {
    if (self = [super initWithService:service params:params]) {
        [self initViewModel];
    }
    return self;
}


- (void)initViewModel {
//    @weakify(self);
    self.refershCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        [[SLRequestManager postWithURL:@"http://www.jiuyunda.net:90/api/v1/shareIntegral/share_info" parameter:@{@"userinfo_id":[SLUser currentUser].bid,@"customer_id":@"57f8ac945b73294b2d7a97ad"}] subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
        
        return [RACSignal empty];
    }];
    
//    self.shareCommand   = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
//        @strongify(self);
//        [self share];
//
//        return [RACSignal empty];
//    }];
}
@end
