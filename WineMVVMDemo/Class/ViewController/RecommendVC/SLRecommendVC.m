//
//  SLRecommendVC.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLRecommendVC.h"
#import "SLRecommendViewModel.h"

@interface SLRecommendVC ()


@property (nonatomic, strong) NSDictionary *dataDic;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *shareBtn;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) SLRecommendViewModel *viewModel;

@end

@implementation SLRecommendVC
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindViewModel];
    
}

-(void)bindViewModel {
    [super bindViewModel];
    [self.viewModel.refershCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        
    }];
    RAC(self.shareBtn,rac_command) = RACObserve(self.viewModel, shareCommand);
}

-(void)configSelf {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:THEME_COLOR] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:SLCOLOR(253, 253, 253, 1)};
}

- (void)configSubView {
    [self.view addSubview:self.imageView];
    
    [self setupTopLabel];
    
    [self setupBottomLabel];
    
    [self setupShareBtn];
    
}

- (void)setupTopLabel {
    UILabel *topLabel = [UILabel labelWithText:@"" font:[UIFont sl_NormalFont:19] textColor:SLCOLOR(70, 70, 70, 1)];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [topLabel setText:@"送给朋友8000积分大礼包，您也可" Font:[UIFont sl_NormalFont:19] withColor:THEME_COLOR Range:NSMakeRange(4, 4)];
    self.topLabel = topLabel;
     [self.view addSubview:topLabel];
}

- (void)setupBottomLabel {
    UILabel *bottomLabel = [UILabel labelWithText:@"" font:[UIFont sl_NormalFont:19] textColor:SLCOLOR(70, 70, 70, 1)];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [bottomLabel setText:@"以获得2000的积分" Font:[UIFont sl_NormalFont:19] withColor:THEME_COLOR Range:NSMakeRange(3, 4)];
    self.bottomLabel = bottomLabel;
    [self.view addSubview:bottomLabel];
}
- (void)setupShareBtn {
    self.shareBtn.titleLabel.font   = [UIFont sl_NormalFont:20];
    self.shareBtn.backgroundColor   = THEME_COLOR;
    [self.shareBtn setTitle:@"分享到社交媒体" forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.shareBtn.layer.cornerRadius = 5;
    self.shareBtn.layer.masksToBounds = YES;
      [self.view addSubview:self.shareBtn];
}

- (void)configConstraint {
    @weakify(self);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(kWidth * 25.0 / 32.0);
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.imageView.mas_bottom).offset(15);
        make.height.equalTo(@37);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel.mas_bottom).offset(5);
        make.left.equalTo(self.topLabel);
        make.right.equalTo(self.topLabel);
        make.height.equalTo(@37);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.bottomLabel.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.height.equalTo(@45);
    }];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:THEME_COLOR_ALPHA] forBarMetrics:UIBarMetricsDefault];
}


- (void)shareBtnClick:(UIButton *)sender
{

    
    [SLTool shared];
    
}

- (UIButton *)shareBtn
{
    if (!_shareBtn)
    {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _shareBtn;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"wtkRecommend"];
    }
    return _imageView;
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
