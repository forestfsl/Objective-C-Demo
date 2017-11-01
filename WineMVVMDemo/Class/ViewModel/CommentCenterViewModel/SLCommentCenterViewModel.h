//
//  SLCommentCenterViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

//评价中心
@interface SLCommentCenterViewModel : SLBaseViewModel
@property(nonatomic,strong)NSMutableArray   *dataArray;

@property(nonatomic,strong)RACCommand       *refreshCommand;

@property(nonatomic,strong)RACCommand       *cellClickCommand;

///评价
@property(nonatomic,strong)RACCommand       *commentCommand;

@end
