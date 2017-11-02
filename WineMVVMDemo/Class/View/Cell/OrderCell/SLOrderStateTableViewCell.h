//
//  SLOrderStateTableViewCell.h
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableViewCell.h"

@interface SLOrderStateTableViewCell : SLBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel        *w_timeLabel;

@property (weak, nonatomic) IBOutlet UIView         *w_topLine;

@property (weak, nonatomic) IBOutlet UIView         *w_bottomLine;

@property (weak, nonatomic) IBOutlet UIImageView    *w_tatusImageView;
@property (weak, nonatomic) IBOutlet UILabel        *w_statusLabel;

@end
