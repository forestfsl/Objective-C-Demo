//
//  SLSiftTableViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLSiftTableViewCell.h"
#import "SLSiftModel.h"

@implementation SLSiftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
      self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configCellData:(id)obj {
    SLSiftModel *model = (SLSiftModel *)obj;
    self.w_Label.text = model.name;
    if (model.isSelected)
    {
        self.w_imageView.hidden = NO;
        self.w_Label.textColor  = THEME_COLOR;
    }
    else
    {
        self.w_Label.textColor  = SLCOLOR(80, 80, 80, 1);
        self.w_imageView.hidden = YES;
    }
}


@end
