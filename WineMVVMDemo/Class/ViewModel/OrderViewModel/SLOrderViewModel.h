//
//  SLOrderViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

@interface SLOrderViewModel : SLBaseViewModel

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) RACCommand *refreshCommand;
@property (nonatomic, strong) RACSubject *menuClickSignal;
@property (nonatomic, strong) RACCommand *cellClickCommand;
@property (nonatomic, assign) NSInteger orderType;

@end
