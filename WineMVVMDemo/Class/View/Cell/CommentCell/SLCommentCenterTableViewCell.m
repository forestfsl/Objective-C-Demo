//
//  SLCommentCenterTableViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLCommentCenterTableViewCell.h"
#import "SLOrderModel.h"
#import "SLOrderDetailModel.h"
#import "SLCommentCenterTableViewCell.h"


@interface SLCommentCenterTableViewCell ()

@property (nonatomic, strong) UIImageView *goodImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) SLOrderModel *order;
@end

@implementation SLCommentCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.commentSubject = [RACSubject subject];
        [self initView];
    }
    return self;
}
- (void)commentBtnClick
{
    [self.commentSubject sendNext:self.order];
    //    [self.commentSubject sendCompleted];
}

- (void)initView
{
    self.selectionStyle     = UITableViewCellSelectionStyleNone;
    WS(weakSelf);
    self.goodImg          = [[UIImageView alloc]init];
    self.goodImg.image    = [UIImage imageNamed:@"placehoder2"];
    self.goodImg.layer.borderColor = SLCOLOR(222, 222, 222, 0.8).CGColor;
    self.goodImg.layer.borderWidth = 0.4;
    [self addSubview:self.goodImg];
    [self.goodImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(10);
        make.left.equalTo(weakSelf).offset(10);
        make.bottom.equalTo(weakSelf).offset(-10);
        make.width.equalTo(weakSelf.goodImg.mas_height);
    }];
    
    self.titleLabel       = [[UILabel alloc]init];
    self.titleLabel.textColor = SLCOLOR(80, 80, 80, 1);
    self.titleLabel.font      = [UIFont sl_NormalFont:15];
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.self.titleLabel];
    [self.self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(30);
        make.left.equalTo(weakSelf.goodImg.mas_right).offset(8);
        make.right.equalTo(weakSelf).offset(-8);
        make.bottom.equalTo(weakSelf).offset(-40);
    }];
    
    self.commentBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentBtn  setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    self.commentBtn.titleLabel.font   = [UIFont sl_NormalFont:13];
    self.commentBtn.layer.cornerRadius = 5;
    self.commentBtn.layer.masksToBounds = YES;
    self.commentBtn.layer.borderColor = THEME_COLOR.CGColor;
    self.commentBtn.layer.borderWidth = 0.3;
    [self.commentBtn setTitle:@"评价晒单" forState:UIControlStateNormal];
    [self addSubview:self.commentBtn];
    [self.commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset(-10);
        make.right.equalTo(weakSelf).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    UIView *line            = [[UIView alloc]init];
    line.backgroundColor    = SLCOLOR(199, 199, 199, 1);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-0.7);
        make.height.mas_equalTo(0.7);
    }];
    
}


-(void)configCellData:(id)obj {
    SLOrderModel *order = (SLOrderModel *)obj;
    WS(weakSelf);
    self.order = order;
    if (order.ordergoods.count > 0)
    {
        SLOrderDetailModel *model = order.ordergoods.firstObject;
        [self.goodImg sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:[UIImage imageNamed:@"placehoder2"]];
        [order.ordergoods enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SLOrderDetailModel *detail = obj;
            weakSelf.titleLabel.text = [NSString stringWithFormat:@"%@、%@",weakSelf.titleLabel.text,detail.title];
        }];
    }
}

@end
