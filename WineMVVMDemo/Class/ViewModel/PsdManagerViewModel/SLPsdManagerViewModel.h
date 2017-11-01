//
//  SLPsdManagerViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

@interface SLPsdManagerViewModel : SLBaseViewModel

/**原密码*/
@property(nonatomic,copy)NSString     *sl_originPsd;
/**新密码*/
@property (nonatomic, copy) NSString *sl_newPsd;
/**确定*/
@property(nonatomic,copy)NSString     *sl_confirmPsd;

/**是否可以更改*/
@property(nonatomic,strong)RACSignal    *canSignal;

/**确认修改*/
@property(nonatomic,strong)RACCommand   *confirmCommand;

@end
