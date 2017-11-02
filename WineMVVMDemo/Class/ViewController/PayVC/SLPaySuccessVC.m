//
//  SLPaySuccessVC.m
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLPaySuccessVC.h"
#import "SLPaySuccessViewModel.h"
#import "SLOrderModel.h"

@interface SLPaySuccessVC ()
@property(nonatomic,strong)SLPaySuccessViewModel       *viewModel;
///查看订单
@property(nonatomic,strong)UIButton                     *orderBtn;

///回首页
@property(nonatomic,strong)UIButton                     *goHomeBtn;
@end

@implementation SLPaySuccessVC
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindViewModel];
    [self initView];
}
- (void)bindViewModel
{
    [super bindViewModel];
    RAC(self.orderBtn,rac_command)  = RACObserve(self.viewModel, orderCommand);
    RAC(self.goHomeBtn,rac_command) = RACObserve(self.viewModel, goHomeCommand);
}

- (void)initView
{
    self.view.backgroundColor       = [UIColor whiteColor];
    @weakify(self);
    UIImageView *bgImageView        = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"w_success_bg"]];
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(84 + 64);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(100);
    }];
    
    UIImageView *successImg         = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"w_pay_success"]];
    [self.view addSubview:successImg];
    [successImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view).offset(34 + 64);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(150);
    }];
    
    UIImageView *duihao             = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"w_paySuccess"]];
    [self.view addSubview:duihao];
    [duihao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(successImg.mas_right);
        make.centerY.equalTo(successImg.mas_bottom);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *tipLabel               = [[UILabel alloc]init];
    tipLabel.font                   = [UIFont sl_NormalFont:18];
    tipLabel.textColor              = SLCOLOR(70, 70, 70, 1);
    tipLabel.text                   = @"订单提交成功";
    tipLabel.textAlignment          = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(successImg.mas_bottom).offset(30);
        make.centerX.equalTo(successImg);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(kWidth);
    }];
    
    UILabel *payType                = [[UILabel alloc]init];
    payType.font                    = [UIFont sl_NormalFont:15];
    payType.textAlignment           = NSTextAlignmentRight;
    payType.textColor               = SLCOLOR(150, 150, 150, 1);
    NSInteger a                     = [self.viewModel.orderModel.ordertype integerValue];
    payType.text                    = a == 1 ? @"微信支付：" : a == 2 ? @"支付宝支付：" : @"货到付款：";
    [self.view addSubview:payType];
    [payType mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.view.mas_centerX);
        make.top.equalTo(tipLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    
    UILabel *priceLabel             = [[UILabel alloc]init];
    priceLabel.font                 = [UIFont sl_NormalFont:15];
    priceLabel.textColor            = THEME_COLOR;
    priceLabel.text                 = [NSString stringWithFormat:@" ¥%.2f",self.viewModel.orderModel.paycost];
    [self.view addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(payType);
        make.left.equalTo(payType.mas_right).offset(2);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    self.orderBtn.titleLabel.font   = [UIFont sl_NormalFont:17];
    _orderBtn.layer.cornerRadius    = 5;
    _orderBtn.layer.masksToBounds   = YES;
    _orderBtn.layer.borderColor     = SLCOLOR(198, 198, 198, 1).CGColor;
    _orderBtn.layer.borderWidth     = 0.3;
    [_orderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [_orderBtn setTitleColor:SLCOLOR(200, 200, 200, 1) forState:UIControlStateNormal];
    [self.view addSubview:self.orderBtn];
    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payType.mas_bottom).offset(18);
        make.right.equalTo(payType.mas_right).offset(-5);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(45);
    }];
    
    self.goHomeBtn.titleLabel.font  = [UIFont sl_NormalFont:17];
    _goHomeBtn.layer.cornerRadius   = 5;
    _goHomeBtn.layer.masksToBounds  = YES;
    _goHomeBtn.layer.borderColor    = SLCOLOR(198, 198, 198, 1).CGColor;
    _goHomeBtn.layer.borderWidth    = 0.3;
    [_goHomeBtn setTitle:@"回首页" forState:UIControlStateNormal];
    [_goHomeBtn setTitleColor:SLCOLOR(200, 200, 200, 1) forState:UIControlStateNormal];
    [self.view addSubview:self.goHomeBtn];
    [self.goHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payType.mas_bottom).offset(18);
        make.left.equalTo(payType.mas_right).offset(5);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(45);
    }];
    
}

- (UIButton *)orderBtn
{
    if (!_orderBtn)
    {
        _orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _orderBtn;
}
- (UIButton *)goHomeBtn
{
    if (!_goHomeBtn)
    {
        _goHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _goHomeBtn;
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
