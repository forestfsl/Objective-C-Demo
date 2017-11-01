//
//  SLShoppingCartTableView.h
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableView.h"
@class SLShoppingCartViewModel;

@interface SLShoppingCartTableView : SLBaseTableView

@property(nonatomic,strong)NSArray                  *dataArray;

@property(nonatomic,strong)SLShoppingCartViewModel  *viewModel;


- (void)sl_reloadData;

@end
