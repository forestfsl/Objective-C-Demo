//
//  SLAddressVC.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLAddressVC.h"
#import "SLAddressViewModel.h"
#import "SLSexView.h"


@interface SLAddressVC ()<UITextFieldDelegate>
@property(nonatomic,strong)SLAddressViewModel   *viewModel;

@property(nonatomic,strong)UITextField              *nameTXF;

@property(nonatomic,strong)UITextField              *phoneTXF;

@property(nonatomic,strong)UITextField              *addressTXF;

@property(nonatomic,strong)UITextField              *detailTXF;

@property(nonatomic,strong)UIScrollView             *scrollView;
/// 通讯录
@property(nonatomic,strong)UIButton                 *phoneBook;

@property(nonatomic,strong)SLSexView               *sexView;

@property(nonatomic,strong)UIButton                 *saveBtn;

@property(nonatomic,strong)UIButton                 *deleteBtn;

@property(nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UIView *sperateLine1;
@property (nonatomic, strong) UIView *sperateLine2;
@property (nonatomic, strong) UIView *sperateLine3;

@property (nonatomic, strong) UILabel *middleLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) UILabel *detailLabel;


@end

@implementation SLAddressVC

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindViewModel];
}
- (void)bindViewModel
{
    [super bindViewModel];
    @weakify(self);
    self.viewModel.vc = self;
    RAC(self.phoneBook,rac_command)     = RACObserve(self.viewModel, phoneBookCommand);
    //    RAC(self.saveBtn,rac_command)       = RACObserve(self.viewModel, saveCommand);
    //    需传值
    [[self.saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.saveCommand execute:@{@"name":self.nameTXF.text,
                                              @"sex":@(self.sexView.w_sex),
                                              @"phone":self.phoneTXF.text,
                                              @"address":self.addressTXF.text,
                                              @"detailAddress":self.detailTXF.text}];
        
    }];
    if (self.viewModel.address)
    {
        [[self.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.viewModel.deleteCommand execute:@1];
        }];
    }
    
    //    从通讯录选取联系人
    RAC(self.phoneTXF,text)             = RACObserve(self.viewModel, phoneNum);
    RAC(self.nameTXF,text)              = RACObserve(self.viewModel, phoneName);
    RAC(self.addressTXF,text)           = RACObserve(self.viewModel, addressString);
}

- (void)configSelf {
    
    if (self.viewModel.address)
    {
        //        如果viewModel有address，本次不是创建
        self.nameTXF.text   = self.viewModel.address.name;
        self.phoneTXF.text  = self.viewModel.address.phone;
        self.addressTXF.text= self.viewModel.address.address;
        self.detailTXF.text = self.viewModel.address.detailAddress;
        self.sexView.w_sex  = self.viewModel.address.sex;
    }
}

- (void)setupScrollView {
    self.scrollView                     = [[UIScrollView alloc]init];
    self.scrollView.contentSize         = CGSizeMake(kWidth, kHeight - 64);
    _scrollView.alwaysBounceVertical    = YES;
    [self.view addSubview:self.scrollView];
}

- (void)setupBgView {
    UIView *bgView                      = [[UIView alloc]init];
    bgView.backgroundColor              = [UIColor whiteColor];
    self.bgView = bgView;
    [self.scrollView addSubview:bgView];
}

- (void)setupTopLabel {
    UILabel *topLabel                   = [[UILabel alloc]init];
    topLabel.textColor                  = SLCOLOR(120, 120, 120, 1);
    topLabel.text                       = @"联 系 人";
    topLabel.font                       = [UIFont sl_NormalFont:14];
    self.topLabel = topLabel;
    [self.bgView addSubview:topLabel];
}


- (void)setupNameText {
    self.nameTXF.font                   = [UIFont sl_NormalFont:14];
    self.nameTXF.placeholder            = @"请输入姓名";
    [self.bgView addSubview:self.nameTXF];
}

- (void)setupPhoneBook {
    [self.phoneBook setBackgroundImage:[UIImage imageNamed:@"phonebook"] forState:UIControlStateNormal];
    [self.bgView addSubview:self.phoneBook];
}

-(void)setupSexView{
    [self.bgView addSubview:self.sexView];
}

- (void)setupSperateLine1 {
    self.sperateLine1                       = [[UIView alloc]init];
    self.sperateLine1 .backgroundColor               = SLCOLOR(215, 215, 215, 1);
    [self.bgView addSubview:self.sperateLine1 ];
}

- (void)setupMiddleLabel {
    UILabel *midLabel                   = [[UILabel alloc]init];
    midLabel.text                       = @"手机号码";
    midLabel.textColor                  = SLCOLOR(120, 120, 120, 1);
    midLabel.font                       = [UIFont sl_NormalFont:14];
    self.middleLabel = midLabel;
    [self.bgView addSubview:midLabel];
}

- (void)setupBottomLabel {
    UILabel *bottomLabel                = [[UILabel alloc]init];
    bottomLabel.text                    = @"地址";
    bottomLabel.textColor               = SLCOLOR(120, 120, 120, 1);
    bottomLabel.font                    = [UIFont sl_NormalFont:14];
    self.bottomLabel = bottomLabel;
    [self.bgView addSubview:bottomLabel];
}

- (void)setupPhoneTXF {
    self.phoneTXF.font                  = [UIFont sl_NormalFont:14];
    self.phoneTXF.placeholder           = @"请输入手机号";
    [self.bgView addSubview:self.phoneTXF];
}

- (void)setupAddressTXF {
    self.addressTXF.font                  = [UIFont sl_NormalFont:14];
    self.addressTXF.placeholder           = @"请选择地址";
    self.addressTXF.adjustsFontSizeToFitWidth = YES;
    [self.bgView addSubview:self.addressTXF];
}

- (void)setupSperateLine2 {
    UIView *line2                       = [[UIView alloc]init];
    line2.backgroundColor               = SLCOLOR(215, 215, 215, 1);
    self.sperateLine2 = line2;
    [self.bgView addSubview:line2];
}

- (void)setupDetailLabel {
    UILabel *detail                 = [[UILabel alloc]init];
    detail.text                     = @"详细地址";
    detail.textColor                = SLCOLOR(120, 120, 120, 1);
    detail.font                     = [UIFont sl_NormalFont:14];
    self.detailLabel = detail;
    [self.bgView addSubview:detail];
}

- (void)setupDetailTXF {
    self.detailTXF.font                 = [UIFont sl_NormalFont:14];
    self.detailTXF.placeholder          = @"请输入详细地址";
    [self.bgView addSubview:self.detailTXF];
}

- (void)setupSperateLine3 {
    UIView *line3                       = [[UIView alloc]init];
    line3.backgroundColor               = SLCOLOR(215, 215, 215, 1);
    self.sperateLine3 = line3;
    [self.bgView addSubview:line3];
}

- (void)setupSaveBtn {
    
    _saveBtn.backgroundColor            = [UIColor whiteColor];
    _saveBtn.layer.cornerRadius         = 5;
    _saveBtn.layer.masksToBounds        = YES;
    _saveBtn.layer.borderColor          = THEME_COLOR.CGColor;
    _saveBtn.layer.borderWidth          = 0.4;
    _saveBtn.titleLabel.font            = [UIFont sl_NormalFont:20];
    [_saveBtn setTitle:@"保存地址" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    [self.scrollView addSubview:self.saveBtn];
}

- (void)setupDeleteBtn {
   
    _deleteBtn.backgroundColor            = SLCOLOR(210, 210, 210, 1);
    _deleteBtn.layer.cornerRadius         = 5;
    _deleteBtn.layer.masksToBounds        = YES;
    _deleteBtn.layer.borderColor          = THEME_COLOR.CGColor;
    _deleteBtn.layer.borderWidth          = 0.4;
    _deleteBtn.titleLabel.font            = [UIFont sl_NormalFont:20];
    [_deleteBtn setTitle:@"删除地址" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:THEME_COLOR forState:UIControlStateNormal];
     [self.scrollView addSubview:self.deleteBtn];
}
-(void)configSubView {
    [self setupScrollView];
    
    [self setupBgView];
    
    [self setupTopLabel];
    
    [self setupNameText];
    
    [self setupPhoneBook];
    
    [self setupSexView];
    
    [self setupSperateLine1];
    
    [self setupMiddleLabel];
    
    [self setupPhoneTXF];
    
    [self setupBottomLabel];
    
    [self setupAddressTXF];
    
    [self setupSperateLine2];
    
    [self setupDetailLabel];
   
    [self setupDetailTXF];
    
    [self setupSperateLine3];
    
    [self setupSaveBtn];
    
    if (self.viewModel.address)
    {
        [self setupDeleteBtn];
        
    }
}

-(void)configConstraint {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(self.view);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(15);
        make.left.equalTo(self.scrollView);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(200);
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView);
        make.left.equalTo(self.bgView).offset(10);
        make.height.mas_equalTo(39.7);
        make.width.mas_equalTo(80);
    }];
    
    [self.nameTXF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(80);
        make.top.equalTo(self.bgView);
        make.right.equalTo(self.bgView).offset(-80);
        make.height.mas_equalTo(39.7);
    }];
    
    [self.phoneBook mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-20);
        make.top.equalTo(self.bgView).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameTXF);
        make.top.equalTo(self.nameTXF.mas_bottom);
        make.right.equalTo(self.phoneBook.mas_left);
        make.height.mas_equalTo(40);
    }];
    
    [self.sperateLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView);
        make.top.equalTo(self.sexView.mas_bottom);
        make.height.mas_equalTo(0.4);
    }];
    
    [self.middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexView.mas_bottom);
        make.left.equalTo(self.bgView).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(39.6);
    }];
    
    [self.phoneTXF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.middleLabel);
        make.left.equalTo(self.middleLabel.mas_right);
        make.right.equalTo(self.bgView);
        make.height.mas_equalTo(39.6);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTXF.mas_bottom);
        make.left.equalTo(self.bgView).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(39.6);
    }];
    
    [self.addressTXF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomLabel);
        make.left.equalTo(self.bottomLabel.mas_right);
        make.right.equalTo(self.bgView);
        make.bottom.equalTo(self.bottomLabel);
    }];
    
    [self.sperateLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView).offset(-39.8 - 40);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressTXF.mas_bottom);
        make.left.equalTo(self.bgView).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    
    [self.detailTXF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.detailLabel);
        make.left.equalTo(self.detailLabel.mas_right);
        make.right.equalTo(self.bgView);
        make.height.mas_equalTo(40);
    }];
    [self.sperateLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView).offset(-39.8);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_bottom).offset(30);
        make.centerX.equalTo(self.bgView);
        make.width.mas_equalTo(kWidth - 60);
        make.height.mas_equalTo(40);
    }];
    
    if (self.viewModel.address) {
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.saveBtn.mas_bottom).offset(30);
            make.centerX.equalTo(self.bgView);
            make.width.mas_equalTo(kWidth - 60);
            make.height.mas_equalTo(40);
        }];
    }
}
#pragma mark - lazyLoad
- (UITextField *)nameTXF
{
    if (!_nameTXF)
    {
        _nameTXF = [[UITextField alloc]init];
    }
    return _nameTXF;
}
- (UITextField *)phoneTXF
{
    if (!_phoneTXF)
    {
        _phoneTXF = [[UITextField alloc]init];
        _phoneTXF.delegate = self;
    }
    return _phoneTXF;
}
- (UITextField *)addressTXF
{
    if (!_addressTXF)
    {
        _addressTXF = [[UITextField alloc]init];
        _addressTXF.delegate = self;
    }
    return _addressTXF;
}
- (UIButton *)phoneBook
{
    if (!_phoneBook)
    {
        _phoneBook = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _phoneBook;
}
- (SLSexView *)sexView
{
    if (!_sexView)
    {
        _sexView = [[SLSexView alloc]init];
    }
    return _sexView;
}
- (UIButton *)saveBtn
{
    if (!_saveBtn)
    {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _saveBtn;
}
- (UITextField *)detailTXF
{
    if (!_detailTXF)
    {
        _detailTXF = [[UITextField alloc]init];
    }
    return _detailTXF;
}
- (UIButton *)deleteBtn
{
    if (!_deleteBtn)
    {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _deleteBtn;
}

#pragma mark - textViewDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == self.addressTXF)
    {
        [self.viewModel.addressCommand execute:textField];
        return NO;
    }
    return YES;
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
