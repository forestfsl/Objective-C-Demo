//
//  SLCommentBtn.m
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLCommentBtn.h"

@interface SLCommentBtn ()

@property (nonatomic, strong, readwrite) UILabel *sl_titleLabel;
@property (nonatomic, strong, readwrite) UILabel *sl_subLabel;
@end

@implementation SLCommentBtn

- (void)initViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle {
    WS(weakSelf);
    self.sl_titleLabel               = [[UILabel alloc]init];
    self.sl_titleLabel.textColor     = SLCOLOR(80, 80, 80, 1);
    self.sl_titleLabel.textAlignment = NSTextAlignmentCenter;
    self.sl_titleLabel.font          = [UIFont sl_NormalFont:15];
    self.sl_titleLabel.text          = title;
    [self addSubview:self.sl_titleLabel];
    [self.sl_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(weakSelf);
        make.height.mas_equalTo(22);
    }];
    
    self.sl_subLabel                 = [[UILabel alloc]init];
    self.sl_subLabel.textColor       = SLCOLOR(80, 80, 80, 1);
    self.sl_subLabel.textAlignment   = NSTextAlignmentCenter;
    self.sl_subLabel.font            = [UIFont sl_NormalFont:14];
    self.sl_subLabel.text            = subTitle;
    [self addSubview:self.sl_subLabel];
    [self.sl_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf);
        make.width.equalTo(weakSelf);
        make.height.mas_equalTo(22);
    }];
}

-(void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.sl_titleLabel.textColor = titleColor;
    self.sl_subLabel.textColor = titleColor;
}

-(void)setTitle:(NSString *)title subTitle:(NSString *)subTitle {
    self.sl_titleLabel.text = title;
    self.sl_subLabel.text = subTitle;
}

+ (instancetype)buttonWithTitle:(NSString *)title subTitle:(NSString *)subTitle {
    SLCommentBtn *btn = [SLCommentBtn buttonWithType:UIButtonTypeCustom];
    [btn initViewWithTitle:title subTitle:subTitle];
    btn.backgroundColor = [UIColor whiteColor];
    return btn;
}

@end
