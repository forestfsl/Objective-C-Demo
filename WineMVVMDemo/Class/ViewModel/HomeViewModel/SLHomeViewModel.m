//
//  SLHomeViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLHomeViewModel.h"
#import "SLRecommendViewModel.h"
#import "SLOrderViewModel.h"
#import "SLGoodsViewModel.h"
#import "SLQRCodeViewModel.h"
#import "SLSearchViewModel.h"
#import "SLGood.h"

@implementation SLHomeViewModel



- (instancetype)initWithService:(id<SLViewModelServices>)service params:(NSDictionary *)params {
    if (self = [super initWithService:service params:params]) {
        [self initViewModel];
    }
    return self;
}

- (void)initViewModel {
   
    //refreshCommand
    [self setupRefreshCommand];
    //headCommand
    [self setupHeadCommand];
    //btnCommand
    [self setupBtnCommand];
    // goodCommand
    [self setupGoodCommand];
    // naviCommand
    [self setupNaviCommand];
    //searchSubject
    [self setupSearchSubject];
}

- (void)setupRefreshCommand {
     @weakify(self);
    self.refreshCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        SHOW_SVP(@"加载中");
        RACSignal *signal1 = [SLRequestManager getWithURL:@"http://www.jiuyunda.net:90/api/v1/product/slideshow" parameter:@{@"id":CURRENT_USER.bid}];
        [signal1 subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
        RACSignal *signal2 = [SLRequestManager postArrayDataWithURL:Home_Data parameter:nil];
        
        RACSignal *signal3 = [self rac_liftSelector:@selector(updateData:headDic:) withSignalsFromArray:@[signal1,signal2]];
        [signal3 subscribeNext:^(id x) {
            [SVProgressHUD dismiss];
            UICollectionView *collectionView = input;
            if (collectionView.mj_header.isRefreshing) {
                [collectionView reloadData];
                [collectionView.mj_header endRefreshing];
            }
        }];
        return signal3;
    }];
}

- (void)setupHeadCommand {
    self.headCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"%@",input);
        return [RACSignal empty];
    }];
}

- (void)setupBtnCommand {
        self.btnCommand     = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            NSLog(@"%@",input);
            NSInteger tag   = [input integerValue];
            switch (tag) {
                case 100:
                {
                    
                }
                    break;
                case 101:
                {
                    SLRecommendViewModel *viewModel = [[SLRecommendViewModel alloc]initWithService:self.services params:@{@"title":@"推荐有奖"}];
                    self.navImpl.className = @"SLRecommendVC";
                    
                    [self.navImpl pushViewModel:viewModel animated:YES];
                    
                }
                    break;
                case 102:
                {
                    
                }
                    break;
                case 103:
                {
                    SLOrderViewModel *viewModel = [[SLOrderViewModel alloc]initWithService:self.services params:@{@"title":@"全部订单"}];
                    viewModel.orderType = 0;
                    self.navImpl.className = @"SLOrderVC";
                    [self.navImpl pushViewModel:viewModel animated:YES];
                }
                    break;
                default:
                    break;
            }
            return [RACSignal empty];
        }];
}

- (void)setupGoodCommand {
    self.goodCommand    = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        SLGoodsViewModel *viewModel = [[SLGoodsViewModel alloc]initWithService:nil params:@{@"title":@"商品详情"}];
        viewModel.goods = (SLGood *)input;
        self.navImpl.className = @"SLGoodsVC";
        [self.navImpl pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];
}

- (void)setupNaviCommand {
    self.naviCommand    = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        UIButton *btn = input;
        if (btn.tag == 111)
        {
            //            erweima
            SLQRCodeViewModel *viewModel = [[SLQRCodeViewModel alloc]initWithService:self.services params:@{@"title":@"二维码"}];
            self.navImpl.className = @"SLQRCodeVC";
            [self.navImpl pushViewModel:viewModel animated:YES];
        }
        return [RACSignal empty];
    }];
}


- (void)setupSearchSubject {
    self.searchSubject = [RACSubject subject];
    [self.searchSubject subscribeNext:^(id x) {
        //       跳转搜索界面
        SLSearchViewModel *viewModel = [[SLSearchViewModel alloc]initWithService:self.services params:@{@"title":@"搜索"}];
        self.navImpl.className = @"SLSearchVC";
        [self.navImpl pushViewModel:viewModel animated:YES];
    }];
}


- (void)updateData:(id)headArray headDic:(NSArray *)dataArray {
#warning 以后修改
    //    return;
    if ([headArray[@"code"] integerValue] == 100)
    {
        self.headData = headArray[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in dataArray)
        {
            SLGood *good = [[SLGood alloc]initWithDic:dic];
            [array addObject:good];
            
        }
        self.dataArray = [NSArray arrayWithArray:array];
    }
    else
    {
        self.headData = [NSArray array];
        self.dataArray = [NSArray array];
    }
}
@end
