//
//  SLBaseViewController.h
//  WineMVVMDemo
//
//  Created by songlin on 28/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLBaseViewModel.h"

@interface SLBaseViewController : UIViewController

@property (nonatomic, strong, readonly)SLBaseViewModel *viewModel;

- (void)configInterface ;

- (void)configSelf;

- (void)configSubView;

- (void)configConstraint;

- (void)bindViewModel;

- (instancetype)initWithViewModel:(SLBaseViewModel *)viewModel;
@end
