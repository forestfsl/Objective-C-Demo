//
//  SLShoppingCarTableViewCell.h
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableViewCell.h"
@class SLGoodManagerView;
@class SLAddress;

@interface SLShoppingCarTableViewCell : SLBaseTableViewCell
//cell1
@property (weak, nonatomic) IBOutlet UIButton *w_selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *w_goodImageView;

@property (weak, nonatomic) IBOutlet UILabel *w_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *w_priceLabel;
@property (weak, nonatomic) IBOutlet SLGoodManagerView *w_managView;


//cell2

@property (weak, nonatomic) IBOutlet UILabel *w_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *w_phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *w_addressLabel;

@property(nonatomic,strong)SLAddress *address;

@end
