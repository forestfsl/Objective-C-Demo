//
//  SLBaseCollectionViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseCollectionViewCell.h"

@implementation SLBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self configInterface];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [self configInterface];
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
@end
