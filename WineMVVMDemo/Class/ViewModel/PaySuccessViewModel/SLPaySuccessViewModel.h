//
//  SLPaySuccessViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"
@class SLOrderModel;

@interface SLPaySuccessViewModel : SLBaseViewModel

@property(nonatomic,strong)SLOrderModel    *orderModel;
///查看订单
@property(nonatomic,strong)RACCommand       *orderCommand;

///
@property(nonatomic,strong)RACCommand       *goHomeCommand;

@end
