//
//  SLQRCodeViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

@interface SLQRCodeViewModel : SLBaseViewModel

@property(nonatomic,strong)RACCommand       *scanCommand;

@end
