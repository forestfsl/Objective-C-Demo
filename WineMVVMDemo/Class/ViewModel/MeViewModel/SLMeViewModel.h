//
//  SLMeViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

@interface SLMeViewModel : SLBaseViewModel
/**cell点击*/
@property(nonatomic,strong)RACSubject   *cellClickSubject;

/**head点击*/
@property(nonatomic,strong)RACSubject   *headClickSubject;

/**设置*/
@property(nonatomic,strong)RACSubject   *setUpSubject;

@end
