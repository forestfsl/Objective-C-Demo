//
//  SLShoppingCartViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLShoppingCartViewModel.h"
#import "SLAddress.h"
#import "SLGood.h"
#import "SLGoodsViewModel.h"
#import "SLAddressManagerViewModel.h"
#import "SLPayViewModel.h"


@implementation SLShoppingCartViewModel


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
    self.emptySubject           = [RACSubject subject];
    // - 监听价格
    [RACObserve([SLShoppingManager manager], changed) subscribeNext:^(id x) {
        static BOOL isFirst;//是否是第一次检测到没有选中。用来避免多次改变selectAllBtn
        isFirst                 = YES;
        [SLShoppingManager manager].flag   = YES;
        NSDictionary *dic       = [SLShoppingManager manager].goodsDic;
        [[dic allValues] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            SLGood *good = obj;
            if(isFirst && !good.w_isSelected && !self.isClickAllBtn)
            {
                //                self.selectAllBtn.selected = !self.selectAllBtn;
                isFirst = NO;
                self.btnState = NO;
            }
            if (idx == 0)
            {
                [SLShoppingManager manager].price = 0;
            }
            if (good.w_isSelected)
            {
                [SLShoppingManager manager].price += good.price * good.num;
            }
            if (idx == [dic allValues].count - 1 && isFirst && !self.isClickAllBtn)
            {
                self.btnState = YES;
            }
            if(idx == [dic allValues].count - 1)
            {
                //                self.isClickAllBtn = NO;
                self.isClickAllBtn = NO;
            }
            //            self.priceLabel.text    = [NSString stringWithFormat:@"共¥ %.2f",SHOPPING_MANAGER.price];
            self.price = [NSString stringWithFormat:@"共¥ %.2f",[SLShoppingManager manager].price];
        }];
        [SLShoppingManager manager].flag = NO;
        [self.emptySubject sendNext:@([dic allValues].count)];
        
    }];
    
    self.goodClickCommand       = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        SLGoodsViewModel *viewModel = [[SLGoodsViewModel alloc]initWithService:self.services params:@{@"title":@"商品详情"}];
        viewModel.goods = (SLGood *)input;
        self.navImpl.className = @"SLGoodsVC";
        [self.navImpl pushViewModel:viewModel animated:YES];
        
        return [RACSignal empty];
    }];
    
    self.addressCommand         = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        SLAddressManagerViewModel *viewModel = [[SLAddressManagerViewModel alloc]initWithService:self.services params:@{@"title":@"选择地址"}];
        viewModel.isShoppingCar = YES;
        [viewModel.cellClickCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
            self.address = x;
        }];
        self.navImpl.className = @"SLAddressManagerVC";
        [self.navImpl pushViewModel:viewModel animated:YES];
        
        
        return [RACSignal empty];
    }];
    
    self.payCommand             = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        //        是否登录
        if ([self judgeWhetherLogin:YES])
        {
            //        跳转支付
            if ([[self.price substringFromIndex:2] floatValue] > 0)
            {
                SLPayViewModel *viewModel = [[SLPayViewModel alloc]initWithService:self.services params:@{@"title":@"结算付款"}];
                self.navImpl.className = @"SLPayVC";
                NSMutableArray *array = @[].mutableCopy;
                [[[SLShoppingManager manager].goodsDic allValues] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    SLGood *good = obj;
                    if (good.w_isSelected)
                    {
                        [array addObject:obj];
                    }
                }];
                viewModel.goodsArray = array;
                [self.navImpl pushViewModel:viewModel animated:YES];
                
            }
            else
            {
                SHOW_ERROE(@"您还没有选择物品");
                DISMISS_SVP(1.3);
            }
        }
        
        
        return [RACSignal empty];
    }];
    
}
- (SLAddress *)address
{
    if (!_address)
    {
        _address = CURRENT_USER.defaultAddress;
    }
    return _address;
}

@end
