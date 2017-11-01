//
//  SLOrderTableView.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableView.h"

@class SLOrderViewModel;

@interface SLOrderTableView : SLBaseTableView

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) SLOrderViewModel *viewModel;

@end
