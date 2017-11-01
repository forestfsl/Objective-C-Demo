//
//  SLCategoryRightTableView.h
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableView.h"
@class SLCategoryViewModel;

@interface SLCategoryRightTableView : SLBaseTableView
@property(nonatomic,strong)NSArray                  *sectionArray;

@property(nonatomic,strong)NSDictionary             *dataDic;

@property(nonatomic,strong)SLCategoryViewModel     *viewModel;

@end
