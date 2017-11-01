//
//  SLOrderVC.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLOrderVC.h"
#import "SLOrderViewModel.h"
#import "SLOrderMenuView.h"
#import "SLOrderTableView.h"

#define MENU_TAG 154

@interface SLOrderVC ()

@property (nonatomic, strong) SLOrderViewModel *viewModel;
@property (nonatomic, strong) SLOrderTableView *tableView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) SLOrderMenuView *menuView;

@end

@implementation SLOrderVC
@dynamic viewModel;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindViewModel];
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self);
    RAC(self.tableView,dataArray) = RACObserve(self.viewModel, array);
    self.tableView.viewModel = self.viewModel;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self.viewModel.refreshCommand execute:self.tableView];
    }];
    RAC(self.menuView,clickSignal) = RACObserve(self.viewModel, menuClickSignal);
}

- (void)configSelf {
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:SLCOLOR(70, 70, 70, 1)};
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"backbutton_icon3"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    [self.rightBtn addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];

}

- (void)right{
    if([self.view viewWithTag:MENU_TAG])
    {
        [self.menuView dismiss];
    }
    else
    {
        [self.view addSubview:self.menuView];
        [self.menuView beginAnimation];
    }
    
}
- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configSubView {
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel.menuClickSignal sendNext:@(self.viewModel.orderType)];
}

- (SLOrderTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[SLOrderTableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    }
    return _tableView;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn)
    {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"wdiandian"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"wdiandian"] forState:UIControlStateSelected];
        _rightBtn.frame = CGRectMake(0, 0, 23, 18);
    }
    return _rightBtn;
}
- (SLOrderMenuView *)menuView
{
    if (!_menuView)
    {
       
        _menuView = [[SLOrderMenuView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight) withData:@[@"全部订单",@"待付款",@"配送中",@"已配送",@"已完成"]];
        _menuView.tag = MENU_TAG;
    }
    return _menuView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
