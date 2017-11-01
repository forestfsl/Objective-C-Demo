//
//  SLMapViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLMapViewModel.h"
#import <BaiduMapAPI_Search/BMKPoiSearch.h>

@implementation SLMapViewModel

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
    self.addressSubject = [RACSubject subject];
    self.cellClick      = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        BMKPoiInfo *poiInfo = input;
        NSDictionary *dic = @{@"address":poiInfo.address,@"city":poiInfo.city,@"name":poiInfo.name};
        @strongify(self);
        [self.addressSubject sendNext:dic];
        [self.navImpl popViewControllerWithAnimation:YES];
        return [RACSignal empty];
    }];
}

@end
