//
//  SLBaseViewController.m
//  WineMVVMDemo
//
//  Created by songlin on 28/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewController.h"

@interface SLBaseViewController ()

@property (nonatomic, strong, readwrite) SLBaseViewModel *viewModel;

@end

@implementation SLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configInterface];
    self.view.backgroundColor = SLCOLOR(240, 240, 240, 1);
    self.viewModel.navImpl = [[SLViewModelNavigationIml alloc]initWithNavigationController:self.navigationController];
    if (self.navigationController && self != self.navigationController.viewControllers.firstObject)
    {
        [self resetNaviWithTitle:@""];
    }
    
}

- (void)resetNaviWithTitle:(NSString *)title
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"backbutton_icon3"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = barItem; //侧滑手势失效
//    self.navigationItem.backBarButtonItem = barItem; //不影响侧滑手势
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}
- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (instancetype)initWithViewModel:(SLBaseViewModel *)viewModel {
    if (self = [super init]) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)configInterface {
    [self configSelf];
    [self configSubView];
    [self configConstraint];
}

- (void)bindViewModel {
    RAC(self.navigationItem,title) = RACObserve(self.viewModel, title);
}

- (void)configSelf {}

- (void)configSubView {}

- (void)configConstraint {}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc{
    NSLog(@"========>>[%@] %@ 释放成功 <<=========",[self class], self);
}

@end
