//
//  SLOrderDetailTableViewCell.h
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableViewCell.h"

@class SLOrderModel;
@class SLOrderDetailModel;
@class SLGood;

@interface SLOrderDetailTableViewCell : SLBaseTableViewCell
//cell1
@property (weak, nonatomic) IBOutlet UILabel *w_detailSerial;
@property (weak, nonatomic) IBOutlet UILabel *w_detailTime;
@property (weak, nonatomic) IBOutlet UILabel *w_userName;
@property (weak, nonatomic) IBOutlet UILabel *w_userPhone;
@property (weak, nonatomic) IBOutlet UILabel *w_userAddress;
@property (weak, nonatomic) IBOutlet UILabel *w_stateLable;


//cell2
@property (weak, nonatomic) IBOutlet UIImageView *w_detailImg;
@property (weak, nonatomic) IBOutlet UILabel *w_detailName;
@property (weak, nonatomic) IBOutlet UILabel *w_detailPrice;
@property (weak, nonatomic) IBOutlet UILabel *w_detailNumber;
@property (weak, nonatomic) IBOutlet UIView *w_bottomLineView;

//cell3
@property (weak, nonatomic) IBOutlet UILabel *w_PayPrice;
@property (weak, nonatomic) IBOutlet UILabel *w_sendFee;
@property (weak, nonatomic) IBOutlet UILabel *w_jiFenCost;
@property (weak, nonatomic) IBOutlet UILabel *w_couponCost;

- (void)updateCell1:(SLOrderModel *)order;
- (void)updateCell2:(SLOrderDetailModel *)order;
- (void)updateCell3:(SLOrderModel *)order;

- (void)updateCell2WithGoods:(SLGood *)goods;
@end
