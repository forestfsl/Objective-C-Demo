//
//  SLGoodManagerView.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLGoodManagerView.h"
#import "SLGood.h"

#define subviewH 40
#define subviewW 30


@interface SLGoodManagerView ()

@property (nonatomic, strong) UIButton *LeftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *numLable;
@property (nonatomic, assign) NSInteger stokeNum;
@property (nonatomic, strong) SLGood *goods;

@end

@implementation SLGoodManagerView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configInterface];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configInterface];
    }
    return self;
}

-(void)configSelf {
     self.addSubject = [RACSubject subject];
    self.reduceSubject = [RACSubject subject];
    self.backgroundColor = [UIColor clearColor];
}


- (void)configSubView {
    //leftButton
    [self setupLeftButton];
    
    //numLabel
    [self setupNumLabel];
    
    //rightButton
    [self setupRightButton];
}

- (void)setupLeftButton {
    
    self.LeftButton                  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.LeftButton.backgroundColor  = [UIColor clearColor];
    self.LeftButton.layer.masksToBounds=YES;
    self.LeftButton.layer.cornerRadius=subviewH/2;
    self.LeftButton.frame = (CGRect){0, 0, subviewH, subviewH};
    [self.LeftButton addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.LeftButton.hidden = YES;
    [self addSubview:self.LeftButton];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage newImageWithNamed:@"minusbutton_icon" size:(CGSize){30,30}]];
    imageView1.frame = CGRectMake(10, 5, 30, 30);
    [self.LeftButton addSubview:imageView1];
}

- (void)setupNumLabel {
    self.numLable                    = [UILabel labelWithText:@"" font:[UIFont sl_NormalFont:16] textColor:SLCOLOR(40, 40, 40, 1)];
    self.numLable.frame              = (CGRect){ subviewH, 5 , subviewW, subviewW};
    self.numLable.textAlignment      = NSTextAlignmentCenter;
    self.numLable.hidden = YES;
    [self addSubview:self.numLable];
}

- (void) setupRightButton {
    self.rightButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.backgroundColor = [UIColor clearColor];
    self.rightButton.layer.masksToBounds=YES;
    self.rightButton.layer.cornerRadius=subviewH/2;
    self.rightButton.tag = 500;
    self.rightButton.frame = (CGRect){ subviewH+subviewW, 0, subviewH, subviewH};
    [self.rightButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightButton];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage newImageWithNamed:@"plusbutton_icon" size:(CGSize){30,30}]];
    imageView2.frame = CGRectMake(0, 5, 30, 30);
    [self.rightButton addSubview:imageView2];
}


#pragma mark 点击减号的行为
- (void)leftBtnClick:(UIButton *)btn
{
    [SLShoppingManager manager].flag = NO;
    self.num = self.num - 1;
    self.goods.num = self.num;
    if (self.goods.num == 0)
    {
        [[SLShoppingManager manager].goodsDic removeObjectForKey:self.goods.id];
        [self.reduceSubject sendNext:self.goods.id];
    }
    else
    {
        [[SLShoppingManager manager].goodsDic setObject:self.goods forKey:self.goods.id];
    }
    [SLUser currentUser].bageValue--;
}

#pragma mark 点击加号的行为
- (void)rightBtnClick:(UIButton *)btn
{
    [SLShoppingManager manager].flag = NO;
    self.goods.w_isSelected = YES;
    if (self.num >= self.stokeNum)
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@"wtkError"] status:@"库存不足"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    self.num = self.num + 1;
    self.goods.num = self.num;
    [self.addSubject sendNext:[NSNumber numberWithInteger:self.num]];
    [[SLShoppingManager manager].goodsDic setObject:self.goods forKey:self.goods.id];
    //    角标
    [SLUser currentUser].bageValue++;
}

- (void)configViewData:(id)obj {
    SLGood *good = (SLGood *)obj;
    self.stokeNum   = good.stock;
    self.num        = good.num;
    
    self.goods      = good;
}

- (void)setNum:(NSInteger)num
{
    _num = num;
    if (num <= 0)
    {
        self.LeftButton.hidden   = YES;
        self.numLable.hidden     = YES;
    }
    else
    {
        self.LeftButton.hidden   = NO;
        self.numLable.hidden     = NO;
        self.numLable.text       = [NSString stringWithFormat:@"%ld",num];
    }
}

@end
