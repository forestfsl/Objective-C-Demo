//
//  SLSetupTableViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLSetupTableViewCell.h"

@implementation SLSetupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configCellTitle:(NSString *)title subTitle:(NSString *)subTitle {
    self.w_titleLabel.text  = title;
    self.w_subTitle.text    = subTitle;
    if (subTitle.length > 0)
    {
        self.w_imageView.hidden = YES;
    }
    else
    {
        self.w_imageView.hidden = NO;
    }
}

@end
