//
//  SLAboutMeTableViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLAboutMeTableViewCell.h"

@implementation SLAboutMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.w_imageView.layer.cornerRadius = 65 / 2.0;
    self.w_imageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configCellTitle:(NSString *)title subTitle:(NSString *)subTitle {
    self.w_Label.text       = title;
    self.w_subLabel.text    = subTitle;
    if (subTitle.length > 0)
    {
        self.w_imageView.hidden = YES;
    }
}

@end
