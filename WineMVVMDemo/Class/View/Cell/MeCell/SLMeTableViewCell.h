//
//  SLMeTableViewCell.h
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableViewCell.h"

@interface SLMeTableViewCell : SLBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sl_TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sl_subTitleLabel;

@end
