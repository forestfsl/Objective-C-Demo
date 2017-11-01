//
//  SLOrderDetailViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLOrderDetailViewModel.h"
#import "SLOrderModel.h"

@implementation SLOrderDetailViewModel


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
    self.segmentSubject     = [RACSubject subject];
    [self.segmentSubject subscribeNext:^(id x) {
        
        
    }];
    
    self.requestStatusCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal   = [SLRequestManager getWithURL:@"http://www.jiuyunda.net:90/api/v1/order/order_track" parameter:@{@"orderid":self.order.id}];
        [signal subscribeNext:^(id x) {
            NSLog(@"%@",x);
            if ([x[@"code"] integerValue] == 100)
            {
                NSArray *data = x[@"data"];
                NSMutableArray *array = @[].mutableCopy;
                for (NSDictionary *dic in data)
                {
                    [array addObject:dic];
                }
                self.statusArray = array;
            }
            UITableView *tableView = input;
            if (tableView.mj_header.isRefreshing)
            {
                [tableView.mj_header endRefreshing];
            }
        }];
        return [RACSignal empty];
    }];
    
}
@end
