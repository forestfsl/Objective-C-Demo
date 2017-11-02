//
//  SLOrderMenuView.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseView.h"

@interface SLOrderMenuView : SLBaseView

@property(nonatomic,strong)RACSubject *clickSignal;
/**
 *  array 列表菜单(NSString *)
 */
- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)array;

- (void)dismiss;
- (void)beginAnimation;

@end
