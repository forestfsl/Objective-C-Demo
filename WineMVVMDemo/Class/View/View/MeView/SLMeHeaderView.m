//
//  SLMeHeaderView.m
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLMeHeaderView.h"
#import "SLMeViewModel.h"

@implementation SLMeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configView];
    }
    return self;
}

- (void)update
{
    if (CURRENT_USER.isLogin)
    {
        self.noLoginHead.hidden   = YES;
        self.headImage.hidden     = NO;
        self.phoneNum.text        = CURRENT_USER.phoneNum;
        self.phoneNum.hidden      = NO;
        self.right.hidden         = NO;
        self.nickNameLabel.hidden = NO;
        
        if (CURRENT_USER.headImage)
        {
            self.headImage.image  = CURRENT_USER.headImage;
        }
        self.nickNameLabel.text   = CURRENT_USER.nickName;
    }
    else
    {
        self.noLoginHead.hidden   = NO;
        self.headImage.hidden     = YES;
        self.phoneNum.hidden      = YES;
        self.right.hidden         = NO;
        self.nickNameLabel.hidden = YES;
        
    }
}


- (void)configView
{
    @weakify(self);
    UIImageView *bgImg          = [[UIImageView alloc]init];
    bgImg.image                 = [UIImage imageNamed:@"w_beijing"];
    [self addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    self.headImage            = [[UIImageView alloc]init];
    self.headImage.image      = [UIImage imageNamed:@"w_defaultHeader"];
    _headImage.layer.cornerRadius = 75 / 2.0;
    _headImage.layer.masksToBounds = YES;
    self.headImage.hidden     = YES;
    [self addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(64);
        make.left.equalTo(self).offset(25);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(75);
    }];
    
    self.noLoginHead          = [[UIImageView alloc]init];
    self.noLoginHead.image    = [UIImage imageNamed:@"w_noLogin"];
    [self addSubview:self.noLoginHead];
    [self.noLoginHead mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.headImage);
        make.size.equalTo(self.headImage);
    }];
    
    self.nickNameLabel          = [[UILabel alloc]init];
    _nickNameLabel.textColor    = SLCOLOR(252, 252, 252, 1);
    _nickNameLabel.font         = [UIFont sl_NormalFont:16];
    _nickNameLabel.hidden       = YES;
    [self addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.headImage.mas_bottom).offset(-35);
        make.left.equalTo(self.headImage.mas_right).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    self.phoneNum             = [[UILabel alloc]init];
    _phoneNum.textColor       = SLCOLOR(252, 252, 252, 1);
    _phoneNum.font            = [UIFont sl_NormalFont:16];
    _phoneNum.hidden          = YES;
    [self addSubview:self.phoneNum];
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.headImage.mas_right).offset(10);
        make.bottom.equalTo(self.headImage).offset(-10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    _right                    = [[UIImageView alloc]init];
    _right.image              = [UIImage imageNamed:@"w_right"];
    _right.hidden             = YES;
    [self addSubview:_right];
    [_right mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self).offset(-35);
        make.centerY.equalTo(self.headImage);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
    UIButton *topBtn            = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.backgroundColor      = [UIColor clearColor];
    [topBtn addTarget:self action:@selector(topBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:topBtn];
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self).offset(64);
        make.height.mas_equalTo(75);
    }];
    
    UIView *bottomBG            = [[UIView alloc]init];
    bottomBG.backgroundColor    = SLCOLOR(70, 70, 70, 0.3);
    [self addSubview:bottomBG];
    [bottomBG mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@40);
    }];
    
    UIButton *leftBtn           = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.backgroundColor     = [UIColor clearColor];
    [leftBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBG addSubview:leftBtn];
    
    UIButton *rightBtn          = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor    = [UIColor clearColor];
    rightBtn.tag                = 1;
    [rightBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBG addSubview:rightBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomBG);
        make.left.equalTo(bottomBG);
        make.right.equalTo(rightBtn.mas_left);
        make.width.equalTo(rightBtn);
        make.height.equalTo(bottomBG);
    }];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBtn.mas_right);
        make.right.equalTo(bottomBG);
        make.top.equalTo(bottomBG);
        make.width.equalTo(leftBtn);
        make.height.equalTo(bottomBG);
    }];
    
    
    self.collecLabel          = [[UILabel alloc]init];
    _collecLabel.textColor    = SLCOLOR(252, 252, 252, 1);
    _collecLabel.font         = [UIFont sl_NormalFont:14];
    _collecLabel.textAlignment= NSTextAlignmentCenter;
    _collecLabel.text         = @"0";
    [bottomBG addSubview:_collecLabel];
    
    self.historyLabel          = [[UILabel alloc]init];
    _historyLabel.textColor    = SLCOLOR(252, 252, 252, 1);
    _historyLabel.font         = [UIFont sl_NormalFont:14];
    _historyLabel.textAlignment= NSTextAlignmentCenter;
    _historyLabel.text         = @"0";
    [bottomBG addSubview:_historyLabel];
    
    [self.collecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomBG).offset(3);
        make.left.equalTo(bottomBG);
        make.width.equalTo(leftBtn);
        make.height.mas_equalTo(15);
    }];
    
    [self.historyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(bottomBG);
        make.centerY.equalTo(self.collecLabel);
        make.width.equalTo(rightBtn);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *leftLabel          = [[UILabel alloc]init];
    leftLabel.textColor         = SLCOLOR(252, 252, 252, 1);
    leftLabel.font              = [UIFont sl_NormalFont:14];
    leftLabel.textAlignment     = NSTextAlignmentCenter;
    leftLabel.text              = @"收藏";
    [bottomBG addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.collecLabel);
        make.right.equalTo(self.collecLabel);
        make.top.equalTo(self.collecLabel.mas_bottom).offset(3);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *rightLabel         = [[UILabel alloc]init];
    rightLabel.textColor        = SLCOLOR(252, 252, 252, 1);
    rightLabel.font             = [UIFont sl_NormalFont:14];
    rightLabel.textAlignment    = NSTextAlignmentCenter;
    rightLabel.text             = @"足迹";
    [bottomBG addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.historyLabel);
        make.right.equalTo(self.historyLabel);
        make.top.equalTo(self.historyLabel.mas_bottom).offset(3);
        make.height.mas_equalTo(15);
    }];
    
}

- (void)topBtnClick
{
    [self.viewModel.headClickSubject sendNext:@8];
}
- (void)bottomBtnClick:(UIButton *)btn
{
    [self.viewModel.headClickSubject sendNext:@(btn.tag + 9)];
}


- (void)collectBtnClick:(id)sender {
}


@end
