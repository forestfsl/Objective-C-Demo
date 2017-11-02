//
//  SLMeHeaderView.h
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseView.h"

@class SLMeViewModel;

@interface SLMeHeaderView : SLBaseView

@property (strong, nonatomic) UIImageView   *headImage;
@property (strong, nonatomic) UILabel       *nickNameLabel;
@property (strong, nonatomic) UILabel       *phoneNum;
@property (strong, nonatomic) UILabel       *collecLabel;
@property (strong, nonatomic) UILabel       *historyLabel;
@property (strong, nonatomic) UIImageView   *noLoginHead;
@property (strong, nonatomic) UIImageView   *right;

@property(nonatomic,strong)   SLMeViewModel*viewModel;

/**刷新，根据是否登录*/
- (void)update;
@end
