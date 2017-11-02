//
//  SLBaseTableViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableViewCell.h"

@implementation SLBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [self configInterface];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self configInterface];
    }
    return self;
}

-(void)configInterface {
    [self configSelf];
    [self configSubView];
    [self configConstraint];
}



//让子类去执行
- (void)configSelf{}
- (void)configSubView{}
- (void)configConstraint{}
- (void)configCellData:(id)obj{}
- (void)configCellTitle:(NSString *)title subTitle:(NSString *)subTitle {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
