//
//  SLPayViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"
#import "SLGoodsViewModel.h"
#import "SLOrderModel.h"
#import "SLPaySuccessViewModel.h"

@interface SLPayViewModel : SLBaseViewModel
///本次买的商品
@property(nonatomic,strong)NSMutableArray   *goodsArray;
///总费用
@property(nonatomic,assign)CGFloat          price;

///确认付款
@property(nonatomic,strong)RACCommand       *payCommand;

///商品点击
@property(nonatomic,strong)RACCommand       *goodCommand;

@end
