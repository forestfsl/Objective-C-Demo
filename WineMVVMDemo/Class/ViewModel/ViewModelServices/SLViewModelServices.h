//
//  SLViewModelServices.h
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SLBaseViewModel;

@protocol SLViewModelServices <NSObject>

- (void)pushViewModel:(SLBaseViewModel *)viewModel animated:(BOOL)animated;

- (void)popViewControllerWithAnimation:(BOOL)animated;

- (void)popToRootViewModelWithAnimation:(BOOL)animated;

- (void)presentViewModel:(SLBaseViewModel *)viewModel animated:(BOOL)animated complete:(void(^)(void))complete;

//模态弹出vc，用于alert
- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)(void))complete;
