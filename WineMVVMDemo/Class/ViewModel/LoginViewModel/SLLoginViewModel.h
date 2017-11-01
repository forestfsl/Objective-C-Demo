//
//  SLLoginViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"

@interface SLLoginViewModel : SLBaseViewModel


@property(nonatomic,strong)NSString     *phoneNum;

@property(nonatomic,strong)NSString     *codeNum;

@property(nonatomic,strong)RACSignal    *phoneSignal;

@property(nonatomic,strong)RACSignal    *canLoginSignal;

/**是否可以点击发送验证码*/
@property(nonatomic,strong)RACSignal    *canCodeSignal;

@property(nonatomic,strong)RACCommand   *codeCommand;

@property(nonatomic,strong)RACCommand   *loginCommand;

@end
