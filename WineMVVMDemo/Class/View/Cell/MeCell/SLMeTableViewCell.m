//
//  SLMeTableViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLMeTableViewCell.h"

@implementation SLMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configCellTitle:(NSString *)title subTitle:(NSString *)subTitle {
    self.sl_TitleLabel.text = title;
    if (subTitle.length <= 0)
    {
        self.sl_subTitleLabel.hidden = YES;
    }
    else
    {
        self.sl_subTitleLabel.text   = subTitle;
        self.sl_subTitleLabel.hidden = NO;
    }
}

@end
