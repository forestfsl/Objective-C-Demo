//
//  SLSexView.h
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseView.h"

@interface SLSexView : SLBaseView

@property(nonatomic,strong)RACSubject *subject;

///性别 YES-男 NO-女
@property(nonatomic,assign)BOOL     w_sex;@end
