//
//  SLShoppingCarTableViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLShoppingCarTableViewCell.h"
#import "SLGoodManagerView.h"
#import "SLAddress.h"
#import "SLGood.h"


@interface SLShoppingCarTableViewCell ()

@property (nonatomic, strong) SLGood *good;
@end

@implementation SLShoppingCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAddress:(SLAddress *)address
{
    self.w_nameLabel.text   = address.name;
    self.w_phoneLabel.text  = address.phone;
    self.w_addressLabel.text= [NSString stringWithFormat:@"%@%@",address.address,address.detailAddress];
}
- (IBAction)selectedBtnClick:(UIButton *)sender
{
    [SLShoppingManager manager].flag = NO;
    self.good.w_isSelected = !self.good.w_isSelected;
    [SLShoppingManager manager].goodsDic;
    UIImage *image = self.good.w_isSelected ? [UIImage imageNamed:@"w_pay_select"] : [UIImage imageNamed:@"w_pay_normal"];
    [self.w_selectBtn setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)configCellData:(id)obj {
    self.good = (SLGood *)obj;
    [self.w_managView configViewData:self.good];
    self.w_titleLabel.text  = self.good.title;
    self.w_priceLabel.text  = [NSString stringWithFormat:@"%.2f",self.good.price];
    UIImage *image = self.good.w_isSelected ? [UIImage imageNamed:@"w_pay_select"] : [UIImage imageNamed:@"w_pay_normal"];
    [self.w_selectBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.w_goodImageView sd_setImageWithURL:[NSURL URLWithString:self.good.avatar_url] placeholderImage:[UIImage imageNamed:@"placehoder2"]];
}
@end
