//
//  SLSearchResultView.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseView.h"
@class SLSearchViewModel;

@interface SLSearchResultView : SLBaseView

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) SLSearchViewModel *viewModel;
- (void)sl_reloadData;

@end
