//
//  SLGoodManagerView.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseView.h"

@class SLGood;

@interface SLGoodManagerView : SLBaseView

///已添加购物车数量
@property (nonatomic, assign) NSInteger num;

/// 添加到购物车
@property(nonatomic,strong)RACSubject   *addSubject;

///移除时发送信号
@property(nonatomic,strong)RACSubject   *reduceSubject;



@end
