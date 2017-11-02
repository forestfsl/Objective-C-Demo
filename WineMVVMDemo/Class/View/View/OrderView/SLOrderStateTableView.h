//
//  SLOrderStateTableView.h
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableView.h"

@class SLOrderModel;

@interface SLOrderStateTableView : SLBaseTableView
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)SLOrderModel *order;

@end
