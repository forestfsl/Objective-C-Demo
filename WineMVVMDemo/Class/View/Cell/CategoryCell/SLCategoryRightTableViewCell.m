//
//  SLCategoryRightTableViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLCategoryRightTableViewCell.h"
#import "SLGoodManagerView.h"
#import "SLGood.h"


@interface SLCategoryRightTableViewCell ()

@property(nonatomic,strong)UIImageView          *sl_imageView;
///标题
@property(nonatomic,strong)UILabel              *sl_titleLabel;
///price
@property(nonatomic,strong)UILabel              *sl_priceLabel;
//销量
@property(nonatomic,strong)UILabel              *sl_saleCount;
///规格
@property(nonatomic,strong)UILabel              *sl_specLabel;

@property(nonatomic,strong)UILabel              *sl_descLabel;

@property(nonatomic,strong)UILabel              *sl_stokeLabel;

@property(nonatomic,strong)SLGood              *goods;

///加号减号
@property(nonatomic,strong)SLGoodManagerView   *managerView;
@end

@implementation SLCategoryRightTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configInterface];
        [self bind];
      
    }
    return self;
}
- (void)bind
{
    @weakify(self);
    [self.managerView.addSubject subscribeNext:^(id x) {
        @strongify(self);
        [SLTool beginAddAnimationWithImageView:self.sl_imageView animationTime:0.55 startPoint:CGPointZero endPoint:CGPointZero];
    }];
}
- (void)configSelf
{
    @weakify(self);
    [self.managerView.addSubject subscribeNext:^(id x) {
        @strongify(self);
        [SLTool beginAddAnimationWithImageView:self.sl_imageView animationTime:0.55 startPoint:CGPointZero endPoint:CGPointZero];
    }];
}


- (void)updateGood:(SLGood *)goods
{
   
}

- (void)configCellData:(id)obj {
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
    
    self.sl_titleLabel.text      = goods.title;
    self.sl_specLabel.text       = goods.specification;
    self.sl_priceLabel.text      = [NSString stringWithFormat:@"¥ %.2f",goods.price];
    [self.sl_imageView sd_setImageWithURL:[NSURL URLWithString:goods.avatar_url] placeholderImage:[UIImage imageNamed:@"placehoder2"]];
    self.sl_saleCount.text       = [NSString stringWithFormat:@"已售 %d",goods.sale_count];
    [self.managerView configViewData:goods];
    if (goods.stock <= 0)
    {
        self.sl_stokeLabel.hidden= NO;
        self.managerView.hidden = YES;
    }
    else
    {
        self.sl_stokeLabel.hidden= YES;
        self.managerView.hidden = NO;
    }
}


- (void)setupImageView {
    self.sl_imageView            = [[UIImageView alloc]init];
    [self addSubview:self.sl_imageView];
}

- (void)setupDescLabel {
    UILabel *desLabel           = [[UILabel alloc]init];
    desLabel.text               = @"精选";
    desLabel.textAlignment      = NSTextAlignmentCenter;
    desLabel.textColor          = THEME_COLOR;
    desLabel.font = [UIFont systemFontOfSize:11];
    desLabel.layer.cornerRadius = 3;
    desLabel.layer.borderColor  = desLabel.textColor.CGColor;
    desLabel.layer.borderWidth  = 0.5;
    desLabel.layer.masksToBounds = YES;
    self.sl_descLabel = desLabel;
    [self addSubview:desLabel];
}

- (void)setupTitleLabel {
    self.sl_titleLabel           = [[UILabel alloc]init];
    _sl_titleLabel.textColor     = SLCOLOR(70, 70, 70, 1);
    _sl_titleLabel.font          = [UIFont sl_NormalFont:14];
    _sl_titleLabel.numberOfLines = 2;
    _sl_titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [_sl_titleLabel sizeToFit];
    _sl_titleLabel.textAlignment = NSTextAlignmentJustified;
    [self addSubview:_sl_titleLabel];
}

- (void)setupPriceLabel{
    self.sl_priceLabel           = [[UILabel alloc]init];
    _sl_priceLabel.textColor     = THEME_COLOR;
    _sl_priceLabel.font          = [UIFont sl_NormalFont:15];
    [_sl_priceLabel sizeToFit];
    [self addSubview:self.sl_priceLabel];
}

- (void)setupSpecLabel{
    self.sl_specLabel            = [[UILabel alloc]init];
    _sl_specLabel.textColor      = SLCOLOR(150, 150, 150, 1);
    _sl_specLabel.font           = [UIFont sl_NormalFont:13];
    [self addSubview:self.sl_specLabel];
}


-(void)setupSaleLabel {
    self.sl_saleCount            = [[UILabel alloc]init];
    _sl_saleCount.textColor      = self.sl_specLabel.textColor;
    _sl_saleCount.font           = self.sl_specLabel.font;
    [self addSubview:self.sl_saleCount];
}

- (void)setupManagerView {
    self.managerView            = [[SLGoodManagerView alloc]init];
    [self addSubview:self.managerView];
}

- (void)setupStokeLabel {
    self.sl_stokeLabel           = [[UILabel alloc]init];
    _sl_stokeLabel.textColor     = THEME_COLOR;
    _sl_stokeLabel.font          = [UIFont sl_NormalFont:16];
    [self addSubview:self.sl_stokeLabel];
}

- (void)configSubView
{

    [self setupImageView];
    //    精选
    [self setupDescLabel];
    
    [self setupTitleLabel];
   
    [self setupPriceLabel];
  
    [self setupSpecLabel];
    
    [self setupSaleLabel];
    
    [self setupManagerView];
    
    [self setupStokeLabel];
    
    
}

- (void)configConstraint {
    [self.sl_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(5);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
    [self.sl_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sl_imageView).offset(2);
        make.left.equalTo(self.sl_imageView.mas_right).offset(5);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(15);
    }];
    
    [_sl_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sl_descLabel.mas_right).offset(1);
        make.centerY.equalTo(self.sl_descLabel);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(18);
    }];
    
    [self.sl_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sl_descLabel);
        make.bottom.equalTo(self.sl_imageView);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    [self.sl_specLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.sl_descLabel);
        make.bottom.equalTo(self.sl_priceLabel.mas_top);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(18);
    }];
    [self.sl_saleCount mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.sl_priceLabel.mas_right);
        make.centerY.equalTo(self.sl_priceLabel);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
    [self.managerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(110);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
