//
//  SLGoodsViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"
#import "SLGood.h"


@interface SLGoodsViewModel : SLBaseViewModel

@property(nonatomic,strong) SLGood          *goods;

@property(nonatomic,strong)RACCommand       *addCommand;

@property(nonatomic,strong)RACCommand       *clickShopCommand;
///分享
@property(nonatomic,strong)RACCommand       *shareCommand;

@property(nonatomic,strong)NSMutableArray   *commentArray;

@property(nonatomic,strong)NSDictionary     *titleDic;
///刷新评论
@property(nonatomic,strong)RACCommand       *refreshCommand;

///评论类型
@property(nonatomic,strong)RACCommand       *menuCommand;

@end
