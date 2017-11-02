//
//  SLOrderDetailTableViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLOrderDetailTableViewCell.h"
#import "SLOrderModel.h"
#import "SLOrderDetailModel.h"
#import "SLGood.h"

@implementation SLOrderDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateCell1:(SLOrderModel *)order
{
    if ([order.workflow_state isEqualToString:@"generation"])
    {
        self.w_stateLable.text  = @"未付款";
    }
    else if ([order.workflow_state isEqualToString:@"cancelled"])
    {
        self.w_stateLable.text  = @"已取消";
    }
    else if ([order.workflow_state isEqualToString:@"paid"])
    {
        self.w_stateLable.text  = @"待接单";
    }
    else if ([order.workflow_state isEqualToString:@"distribution"])
    {
        self.w_stateLable.text  = @"配送中";
    }
    else if ([order.workflow_state isEqualToString:@"completed"])
    {
        self.w_stateLable.text  = @"已完成";
    }
    else if ([order.workflow_state isEqualToString:@"receive"])
    {
        self.w_stateLable.text  = @"配送完成";
    }
    self.w_detailSerial.text    = order.orderno;
    self.w_detailTime.text      = order.created_at;
    self.w_userName.text        = order.consignee;
    self.w_userPhone.text       = order.telephone;
    self.w_userAddress.text     = order.address;
    
    self.w_stateLable.layer.cornerRadius = 5;
    self.w_stateLable.layer.masksToBounds= YES;
    
}

- (void)updateCell2:(SLOrderDetailModel *)order
{
    [self.w_detailImg sd_setImageWithURL:[NSURL URLWithString:order.avatar_url] placeholderImage:[UIImage imageNamed:@"placehoder2"]];
    self.w_detailName.text      = order.title;
    self.w_detailPrice.text     = [NSString stringWithFormat:@"%.2f",order.price];
    self.w_detailNumber.text    = [NSString stringWithFormat:@"x %d",order.quantity];
}

- (void)updateCell3:(SLOrderModel *)order
{
    self.w_PayPrice.text    = [NSString stringWithFormat:@"¥ %.2f",order.paycost];
    
}

- (void)updateCell2WithGoods:(SLGood *)goods
{
    [self.w_detailImg sd_setImageWithURL:[NSURL URLWithString:goods.avatar_url] placeholderImage:[UIImage imageNamed:@"placehoder2"]];
    self.w_detailName.text      = goods.title;
    self.w_detailPrice.text     = [NSString stringWithFormat:@"%.2f",goods.price * goods.num];
    self.w_detailNumber.text    = [NSString stringWithFormat:@"x %ld",goods.num];
}

@end
