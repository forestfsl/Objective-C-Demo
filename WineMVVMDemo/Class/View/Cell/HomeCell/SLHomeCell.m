//
//  SLHomeCell.m
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLHomeCell.h"
#import "SLGood.h"
#import "SLShoppingManager.h"
#import "SLGoodManagerView.h"

@interface SLHomeCell ()

//商品
@property (nonatomic, strong) UIImageView *imageV;

//标题
@property (nonatomic, strong) UILabel *titleLabel;
//描述文本
@property (nonatomic, strong) UILabel *descLabel;
//价格
@property (nonatomic, strong) UILabel *priceLabel;
//背景视图
@property (nonatomic, strong) UIView *bgView;

//无货
@property (nonatomic, strong) UILabel *stockLabel;

@property (nonatomic, strong) SLGood *goods;

@property (nonatomic, strong) SLGoodManagerView *managerView;


@end

@implementation SLHomeCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configInterface];
    }
    return self;
}

- (void)configSelf {
    self.backgroundColor = [UIColor redColor];
}

- (void)configSubView {
    //bgView
    [self setupBgView];
    
    //imageV
    [self setupImageV];
    
    //titleLabel
    [self setupTitleLabel];
    
    //descLabel
    [self setupDescLabel];
    
    //priceLabel
    [self setupPriceLabel];
    
    //managerView
    [self setupManagerView];
    
    //stockLabel
    [self setupStockLabel];

}
//配置背景View
- (void)setupBgView {
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    self.bgView = bgView;
    [self addSubview:bgView];
}

//设置产品图片
- (void)setupImageV {
    self.imageV  = [[UIImageView alloc]init];
    [self.bgView addSubview:self.imageV];
}

//设置产品文字
- (void)setupTitleLabel {
    self.titleLabel = [UILabel labelWithText:@"" font:SLFONT(15) textColor:SLCOLOR(40, 40, 40, 1)];
    [self.bgView addSubview:self.titleLabel];
}

//设置产品的描述文字
- (void)setupDescLabel {
    self.descLabel = [UILabel labelWithText:@"精选" font:SLFONT(10) textColor:THEME_COLOR];
    [self.descLabel configLabelWithBorderColor:THEME_COLOR borderWidth:0.3 cornerRadius:3 isMask:YES textAlignment:NSTextAlignmentCenter];
    [self.bgView addSubview:self.descLabel];
}

//设置产品的价格
- (void)setupPriceLabel {
    self.priceLabel = [UILabel labelWithText:@"￥135.00" font:SLFONT(14) textColor:THEME_COLOR];
    [self.bgView addSubview:self.priceLabel];
}

//设置库存
- (void)setupStockLabel {
    self.stockLabel = [UILabel labelWithText:@"补货中" font:[UIFont sl_NormalFont:17] textColor:THEME_COLOR];
    self.stockLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.stockLabel];
}

//设置managerView
- (void)setupManagerView {
    self.managerView                = [[SLGoodManagerView alloc]init];
    [self.bgView addSubview:self.managerView];
}

- (void)configConstraint {
     CGFloat width = self.bounds.size.width;
    //bgView
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(self);
    }];
    
    //imageV
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.top.equalTo(self.bgView);
        make.width.equalTo(self.bgView);
        make.height.equalTo(self.bgView.mas_width);
    }];
    
    //titleLabel
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(2);
        make.top.equalTo(self.imageV.mas_bottom).offset(5);
        make.width.mas_equalTo(width - 4);
        make.height.equalTo(@15);
    }];
    
    //descLabel
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(2);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(30 * ZOOM_SCALL);
        make.height.mas_equalTo(15);
    }];
    
    //priceLabel
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(1);
        make.top.equalTo(self.descLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(100 * ZOOM_SCALL);
        make.height.equalTo(@15);
    }];
    
    //managerView
    [self.managerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(0);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-10);
        make.width.mas_equalTo(110);
        make.height.equalTo(@40);
    }];
    
    [self.stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.managerView);
        make.right.equalTo(self.managerView);
        make.size.equalTo(self.managerView);
    }];
}


-(void)configCellData:(id)obj {
    SLGood *goods = (SLGood *)obj;
    //  检查购物车是否有商品
    if ([[SLShoppingManager manager].goodsDic objectForKey:goods.id])
    {
        SLGood *good = [[SLShoppingManager manager].goodsDic objectForKey:goods.id];
        goods.num = good.num ;
    }
    else
    {
        //        car没有这个商品
        goods.num = 0;
    }
    
    
    self.goods = goods;
    self.titleLabel.text = goods.title;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",goods.price];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:goods.thumb_url] placeholderImage:[UIImage imageNamed:@"placehoder2"]];
    if (goods.stock <= 0)
    {
        self.stockLabel.hidden   = NO;
        self.managerView.hidden     = YES;
    }
    else
    {
        self.stockLabel.hidden   = YES;
        self.managerView.hidden     = NO;
        [self.managerView configViewData:goods];
    }
}

@end
