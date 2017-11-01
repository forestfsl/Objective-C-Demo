//
//  SLAboutMeView.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseView.h"

@interface SLAboutMeView : SLBaseView

@property(nonatomic,strong)RACSubject   *clickSubject;

/**
 * 初始化
 * param titleArray 标题(1-3个)
 */
- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray<NSString *> *)titleArray;
@end
