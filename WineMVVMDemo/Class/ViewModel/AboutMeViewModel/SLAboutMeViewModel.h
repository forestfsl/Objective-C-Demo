//
//  SLAboutMeViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

@class SLAboutMeVC;

@interface SLAboutMeViewModel : SLBaseViewModel

@property(nonatomic,strong)RACCommand   *cellClickCommand;

@property(nonatomic,weak)SLAboutMeVC   *vc;

@end
