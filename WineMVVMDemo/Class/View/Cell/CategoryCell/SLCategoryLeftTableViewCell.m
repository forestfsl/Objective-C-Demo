//
//  SLCategoryLeftTableViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLCategoryLeftTableViewCell.h"

@implementation SLCategoryLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = SLCOLOR(240, 240, 240, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.backgroundColor    = selected ? [UIColor whiteColor] : SLCOLOR(242, 242, 242, 1);
    self.w_label.textColor  = selected ? THEME_COLOR : SLCOLOR(70, 70, 70, 1);

    // Configure the view for the selected state
}

@end
