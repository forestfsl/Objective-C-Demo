//
//  SLHomeViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"


@interface SLHomeViewModel : SLBaseViewModel

//刷新数据
@property (nonatomic, strong) RACCommand *refreshCommand;

@property (nonatomic, strong) NSArray *headData;

@property (nonatomic, strong) NSArray *dataArray;

//头视图
@property (nonatomic, strong) RACCommand *headCommand;

//中间按钮点击
@property (nonatomic, strong) RACCommand *btnCommand;

//good
@property (nonatomic, strong) RACCommand *goodCommand;

//导航栏
@property (nonatomic, strong) RACCommand *naviCommand;

@property (nonatomic, strong) RACSubject *searchSubject;

@end
