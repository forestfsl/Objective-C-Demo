//
//  SLViewModelNavigationIml.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLViewModelNavigationIml.h"
#import "SLBaseViewController.h"

@interface SLViewModelNavigationIml ()

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation SLViewModelNavigationIml

- (instancetype)initWithNavigationController:(UINavigationController *)navi {
    if (self = [super init]) {
        _navigationController = navi;
    }
    return self;
}

-(void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    _navigationController.tabBarController.selectedIndex = selectedIndex;
}
- (void)pushViewModel:(SLBaseViewModel *)viewModel animated:(BOOL)animated {
    if (!_navigationController) {
        NSLog(@"没有导航");
        SHOW_ERROE(@"导航错误");
        DISMISS_SVP(1.2);
        return;
    }
    if (_className.length <= 0) {
        [SVProgressHUD showWithStatus:@"错误,未指定viewController"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    SLBaseViewController *vc = [[NSClassFromString(_className) alloc]initWithViewModel:viewModel];
    if (!vc)
    {
        NSLog(@"VC名字错误:%@控制类不存在",_className);
        return;
    }
    [_navigationController pushViewController:vc animated:animated];
}

- (void)popViewControllerWithAnimation:(BOOL)animated
{
    if (!_navigationController)
    {
        NSLog(@"没有导航");
        return;
    }
    
    [_navigationController popViewControllerAnimated:animated];
}
- (void)popToRootViewModelWithAnimation:(BOOL)animated
{
    if (!_navigationController)
    {
        NSLog(@"没有导航");
        return;
    }
    
    [_navigationController popToRootViewControllerAnimated:animated];
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void (^)(void))complete {
    if (!_navigationController)
    {
        SHOW_ERROE(@"导航错误");
        DISMISS_SVP(1.2);
        return;
    }
    [_navigationController presentViewController:viewController animated:animated completion:complete];
}


- (void)presentViewModel:(SLBaseViewModel *)viewModel animated:(BOOL)animated complete:(void (^)(void))complete {
    if (!_navigationController)
    {
        NSLog(@"没有导航");
        //        return;
    }
    if (_className.length <= 0)
    {
        [SVProgressHUD showWithStatus:@"错误,未指定viewController"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    SLBaseViewController *vc = [[NSClassFromString(_className) alloc]initWithViewModel:viewModel];
    if (!vc)
    {
        NSLog(@"VC名字错误:%@控制类不存在",_className);
        return;
    }
    [_navigationController presentViewController:vc animated:animated completion:complete];
}


@end
