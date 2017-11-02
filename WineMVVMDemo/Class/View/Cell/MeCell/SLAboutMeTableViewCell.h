//
//  SLAboutMeTableViewCell.h
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableViewCell.h"

@interface SLAboutMeTableViewCell : SLBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *w_Label;
@property (weak, nonatomic) IBOutlet UIImageView *w_imageView;
@property (weak, nonatomic) IBOutlet UILabel *w_subLabel;

@end
