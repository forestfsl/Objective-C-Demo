//
//  SLSetupViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

@interface SLSetupViewModel : SLBaseViewModel
@property(nonatomic,strong)RACSubject *cellClickSubject;

@property(nonatomic,strong)RACSubject *exitSubject;

@end
