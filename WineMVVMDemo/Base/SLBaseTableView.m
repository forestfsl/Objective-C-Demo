//
//  SLBaseTableView.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableView.h"

@implementation SLBaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
//        [self configInterface];
    }
    return self;
}


- (void)configInterface {
    [self configSelf];
    [self configSubView];
    [self configConstraint];
}



- (void) create{}

- (void)configSelf{}

- (void)configSubView{}

- (void)configConstraint{}

- (void)configTableViewData:(id)obj{}
@end
