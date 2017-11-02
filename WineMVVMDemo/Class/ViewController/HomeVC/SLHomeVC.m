//
//  SLHomeVC.m
//  WineMVVMDemo
//
//  Created by songlin on 28/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLHomeVC.h"
#import "SLHomeCollectionView.h"
#import "SLSearchBar.h"

@interface SLHomeVC ()<UISearchBarDelegate>

@property (nonatomic, strong) SLHomeViewModel *viewModel;
@property (nonatomic, strong) SLHomeCollectionView *collectionView;
@property (nonatomic, strong) SLSearchBar *searchBar;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *leftBtn;

//是否为显示页面（控制collectionView）
@property (nonatomic, assign) BOOL isShow;

@end

@implementation SLHomeVC
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelPop) name:@"wtk_cancelPop" object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isShow = YES;
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:SLCOLOR(255, 255, 255, 0.01)] forBarMetrics:UIBarMetricsDefault];
    [self setNavigationItem];
    self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y + 0.02);
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isShow = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:SLCOLOR(255, 255, 255, 0.99)] forBarMetrics:UIBarMetricsDefault];
}

- (void)configSelf {
        if (@available(iOS 11.0, *)) {
            self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
           self.automaticallyAdjustsScrollViewInsets = NO;
        }
}

-(void)configSubView {
    [self.view addSubview:self.collectionView];
    [self bindViewModel];
}

//绑定数据
- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    //RAC(...)把某个对象的属性与信号绑定起来。这里把collectionView的dataArray与viewModel的dataArray绑定。
    RAC(self.collectionView,headArray) = RACObserve(self.viewModel, headData);
    RAC(self.collectionView,dataArray)  = RACObserve(self.viewModel,dataArray);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        //collectionView的刷新方法，让viewModel的refreshCommand执行，并且把collectionView传递过去。
        [self.viewModel.refreshCommand execute:self.collectionView];
    }];
    [self.collectionView.mj_header beginRefreshing];
    
    //navi
    RAC(self,leftBtn.rac_command)    = RACObserve(self.viewModel, naviCommand);
    [RACObserve(self.collectionView, contentOffset)
     subscribeNext:^(id x) {
         if (!self.isShow) {
             return ;
         }
         CGPoint point = [x CGPointValue];
         CGFloat y = point.y;
         if (y < kWidth * 0.23) {
             [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"wtksaoyisaob"] forState:UIControlStateNormal];
             [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"xiaoxib"] forState:UIControlStateNormal];
             self.searchBar.sl_bgColor = SLCOLOR(240, 240, 240, 0.5);
         }else {
             [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"wtksaoyisaoh"] forState:UIControlStateNormal];
             [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"xiaoxih"] forState:UIControlStateNormal];
             self.searchBar.sl_bgColor = SLCOLOR(160, 160, 160, 0.5);
         }
         if (y < 0) {
             [self.navigationController setNavigationBarHidden:YES animated:YES];
             self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
         }else {
             [self.navigationController setNavigationBarHidden:NO animated:YES];
             float a = y / kWidth / 0.23 > 0.9 ? 0.9 : y / kWidth / 0.23;
             NSLog(@"%f",a);
             if (a < 0.9 && a >= 0)
             {
                 NSLog(@"11111");
                 [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:SLCOLOR(255, 255, 255, a)] forBarMetrics:UIBarMetricsDefault];
             }
             if (a < 0.5)
             {
                 NSLog(@"22222");
                 self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
             }
             else
             {
                 NSLog(@"333333");
                 self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
             }
         }
     }];
}



//导航
- (void)setNavigationItem {
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"wtksaoyisaoh"] forState:UIControlStateNormal];
    self.leftBtn.frame = CGRectMake(0, 0, 25, 23);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn]
    ;
    
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"xiaoxib"] forState:UIControlStateNormal];
    self.rightBtn.frame = CGRectMake(0, 0, 25, 23);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.center = CGPointMake(kWidth / 2.0, self.searchBar.center.y);
}


#pragma mark - searchDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.viewModel.searchSubject sendNext:@1];
    return NO;
}

#pragma mark -lazyLoad
- (SLHomeCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[SLHomeCollectionView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 49) collectionViewLayout:layout];
        _collectionView.viewModel = self.viewModel;
    }
    return _collectionView;
}

-(UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.tag = 111;
    }
    return _leftBtn;
}

-(UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return _rightBtn;
}

-(SLSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[SLSearchBar alloc]initWithFrame:CGRectMake(0, 60, kWidth - 120, 28)];
        _searchBar.layer.cornerRadius = 5;
        _searchBar.layer.masksToBounds = YES;
        CGRect leftViewbounds = self.navigationItem.leftBarButtonItem.customView.bounds;
        CGRect rightViewbounds = self.navigationItem.rightBarButtonItem.customView.bounds;
        CGRect frame;
        CGFloat maxWidth = leftViewbounds.size.width > rightViewbounds.size.width ? leftViewbounds.size.width : rightViewbounds.size.width;
        maxWidth += 15;//leftview 左右都有间隙，左边是5像素，右边是8像素，加2个像素的阀值 5 ＋ 8 ＋ 2
        frame = _searchBar.frame;
        
        frame.size.width = kWidth - maxWidth * 2;
        
        _searchBar.frame = frame;
        _searchBar.searchBar.delegate = self;
    }
    return _searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"释放了");
    
}





@end
