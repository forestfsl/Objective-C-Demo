//
//  SLFeedBackViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

@interface SLFeedBackViewModel : SLBaseViewModel

///类型
@property(nonatomic,assign)NSInteger    *ideaType;

///提交
@property(nonatomic,strong)RACCommand   *submitConmand;

@end
