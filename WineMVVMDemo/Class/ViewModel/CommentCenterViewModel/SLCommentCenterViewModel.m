//
//  SLCommentCenterViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLCommentCenterViewModel.h"
#import "SLOrderModel.h"
#import "SLOrderDetailViewModel.h"
#import "SLCommentViewModel.h"


@implementation SLCommentCenterViewModel

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
    self.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        SHOW_SVP(@"加载中")
        RACSignal *signal = [SLRequestManager postArrayDataWithURL:@"AllOrder" parameter:@{}];
        [signal subscribeNext:^(id x) {
            DISMISS_SVP(0.01);
            UITableView *table = input;
            if (table.mj_header.isRefreshing)
            {
                [table.mj_header endRefreshing];
            }
            NSArray *xArray = x;
            NSMutableArray *mArray = @[].mutableCopy;
            for (NSDictionary *dic in xArray)
            {
                SLOrderModel *order = [[SLOrderModel alloc]initWithDic:dic];
                [mArray addObject:order];
            }
            self.dataArray = mArray;
        }];
        return [RACSignal empty];
    }];
    
    self.cellClickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        SLOrderDetailViewModel *viewModel = [[SLOrderDetailViewModel alloc]initWithService:self.services params:@{@"title":@"订单详情"}];
        viewModel.order = input;
        self.navImpl.className = @"SLOrderDetailVC";
        [self.navImpl pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];
    
    self.commentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        SLCommentViewModel *viewModel = [[SLCommentViewModel alloc]initWithService:self.services params:@{@"title":@"评价"}];
        viewModel.order = input;
        self.navImpl.className = @"SLCommentVC";
        [self.navImpl pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];
}



#pragma lazyLoad
-(NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

@end
