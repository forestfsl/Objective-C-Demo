//
//  SLSiftView.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseView.h"

@interface SLSiftView : SLBaseView

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)RACSubject *dismissSubject;

///刷新数据
- (void)reloadData;

///移除
- (void)dismiss;

@end
