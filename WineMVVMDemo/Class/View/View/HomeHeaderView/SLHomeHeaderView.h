//
//  SLHomeHeaderView.h
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLHomeHeaderView : UICollectionReusableView

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) RACSubject *bannerSubject;
@property (nonatomic, strong) RACSubject *btnSubject;

@end
