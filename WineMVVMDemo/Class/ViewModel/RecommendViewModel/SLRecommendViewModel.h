//
//  SLRecommendViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

@interface SLRecommendViewModel : SLBaseViewModel

@property (nonatomic, strong) RACCommand *refershCommand;
@property (nonatomic, strong) RACCommand *shareCommand;

@end
