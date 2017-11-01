//
//  SLOrderDetailViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"
@class SLOrderModel;

@interface SLOrderDetailViewModel : SLBaseViewModel

@property(nonatomic,strong)SLOrderModel    *order;

@property(nonatomic,strong)RACSubject       *segmentSubject;

@property(nonatomic,strong)RACCommand       *requestStatusCommand;

@property(nonatomic,strong)NSMutableArray   *statusArray;

/**刷新detailTableView*/
@property(nonatomic,strong)RACCommand       *refreshDetail;

/**刷新statusTableView*/
@property(nonatomic,strong)RACCommand       *refreshStatus;

@end
