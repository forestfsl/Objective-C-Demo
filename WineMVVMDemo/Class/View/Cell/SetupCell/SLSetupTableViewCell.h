//
//  SLSetupTableViewCell.h
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableViewCell.h"

@interface SLSetupTableViewCell : SLBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *w_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *w_subTitle;
@property (weak, nonatomic) IBOutlet UIImageView *w_imageView;


@end
