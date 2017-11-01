//
//  SLMapSearchTableView.h
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableView.h"
@class SLMapViewModel;

@interface SLMapSearchTableView : SLBaseTableView
@property(nonatomic,strong)NSArray *searchArray;

@property(nonatomic,strong)SLMapViewModel *viewModel;
@end
