//
//  SLAddressManagerViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

@interface SLAddressManagerViewModel : SLBaseViewModel

///新建地址
@property(nonatomic,strong)RACCommand       *addAddressCommand;
///编辑地址
@property(nonatomic,strong)RACCommand       *editAddress;

///删除
@property(nonatomic,strong)RACCommand       *deleteAddress;

///判断是否从购物车进来
@property(nonatomic,assign)BOOL             isShoppingCar;

///点击cell
@property(nonatomic,strong)RACCommand       *cellClickCommand;

@end
