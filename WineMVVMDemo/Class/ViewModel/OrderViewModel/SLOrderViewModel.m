//
//  SLOrderViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLOrderViewModel.h"
#import "SLOrderModel.h"
#import "SLOrderDetailViewModel.h"


@interface SLOrderViewModel ()

@property (nonatomic, assign) NSInteger selectType;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@end

@implementation SLOrderViewModel

-(instancetype)initWithService:(id<SLViewModelServices>)service params:(NSDictionary *)params {
    if (self = [super initWithService:service params:params]) {
        self.selectType = 0;
        self.typeArray  = @[@"AllOrder",@"NoPayOrder",@"DeliveryOrder",@"FinshDeliveryOrder",@"FinishOrder"];
        [self initViewModel];
    }
    return self;
}

- (void)initViewModel
{
    self.refreshCommand     = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        [SVProgressHUD showWithStatus:@"加载中"];
        RACSignal *signal = [SLRequestManager postArrayDataWithURL:self.typeArray[self.selectType] parameter:@{}];
        [signal subscribeNext:^(id x) {
            [SVProgressHUD dismiss];
            
            NSMutableArray *mArray = [NSMutableArray array];
            for (NSDictionary *dic in x)
            {
                SLOrderModel *order = [[SLOrderModel alloc]initWithDic:dic];
                [mArray addObject:order];
            }
            self.dataDic[self.typeArray[self.selectType]] = mArray;
            
            self.array = mArray;
            UITableView *tableView = input;
            if (tableView.mj_header.isRefreshing)
            {
                [tableView.mj_header endRefreshing];
            }
        }];
        return signal;
    }];
    
    self.menuClickSignal    = [RACSubject subject];
    [self.menuClickSignal subscribeNext:^(id x) {
        self.selectType     = [x integerValue];
        if (self.dataDic[self.typeArray[self.selectType]])
        {
            self.array = self.dataDic[self.typeArray[self.selectType]];
        }
        else
        {
            //            刷新
            [self.refreshCommand execute:[[UITableView alloc]init]];
        }
        [self resetTitle];
    }];
    
    //    cell
    self.cellClickCommand       = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        SLOrderModel *order    = input;
        SLOrderDetailViewModel *viewModel = [[SLOrderDetailViewModel alloc]initWithService:self.services params:@{@"title":@"订单详情"}];
        viewModel.order         = order;
        self.navImpl.className = @"SLOrderDetailVC";
        [self.navImpl pushViewModel:viewModel animated:YES];
        
        return [RACSignal empty];
    }];
}

/**重设title*/
- (void)resetTitle
{
    self.title = self.selectType == 0 ? @"全部订单" : self.selectType == 1 ? @"待付款" : self.selectType == 2 ? @"配送中" : self.selectType == 3 ? @"已配送" : @"已完成";
}

- (NSMutableDictionary *)dataDic
{
    if (!_dataDic)
    {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}

- (NSMutableArray *)array
{
    if (!_array)
    {
        _array = [NSMutableArray array];
    }
    return _array;
}

@end
