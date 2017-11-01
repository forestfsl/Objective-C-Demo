//
//  SLFunctionViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

@interface SLFunctionViewModel : SLBaseViewModel

@property(nonatomic,strong)RACCommand       *switchCommand;

@end
