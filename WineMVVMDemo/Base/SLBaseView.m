//
//  SLBaseView.m
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseView.h"

@implementation SLBaseView

-(void)awakeFromNib {
    [super awakeFromNib];
    //    [self configInterface];
}

-(instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        //        [self configInterface];
    }
    return self;
}

- (void)configInterface {
    [self configSelf];
    [self configSubView];
    [self configConstraint];
}

- (void)configSelf {}

- (void)configSubView {}

- (void)configConstraint {}

- (void)create {}

- (void)configViewData:(id)obj{}

- (void) dealloc{
    NSLog(@"========>>[%@] %@ 释放成功 <<=========",[self class], self);
}

@end
