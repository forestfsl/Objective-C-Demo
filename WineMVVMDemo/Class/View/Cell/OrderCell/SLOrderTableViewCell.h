//
//  SLOrderTableViewCell.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableViewCell.h"

@class SLOrderModel;

@interface SLOrderTableViewCell : SLBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *w_statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *w_timeLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *w_scrollView;
@property (weak, nonatomic) IBOutlet UILabel *w_priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *w_statusButton;

@property (weak, nonatomic) IBOutlet UIImageView *w_finishImage;

@property (nonatomic,strong)SLOrderModel *order;
@end
