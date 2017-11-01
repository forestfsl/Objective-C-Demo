//
//  SLHomeCollectionView.h
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLHomeViewModel.h"

@interface SLHomeCollectionView : UICollectionView

@property (nonatomic, strong) NSArray *headArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SLHomeViewModel *viewModel;

@end
