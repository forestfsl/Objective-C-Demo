//
//  SLSearchViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

@interface SLSearchViewModel : SLBaseViewModel


/// 搜索
@property(nonatomic,strong)RACCommand       *searchCommand;

///商品点击
@property(nonatomic,strong)RACCommand       *goodCommand;

@property(nonatomic,strong)RACCommand       *shoppingCarCommand;

///删除
@property(nonatomic,strong)RACCommand       *deleteHistory;

@property(nonatomic,weak)UIViewController *vc;

@end
