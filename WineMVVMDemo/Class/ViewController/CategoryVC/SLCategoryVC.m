//
//  SLCategoryVC.m
//  WineMVVMDemo
//
//  Created by songlin on 28/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLCategoryVC.h"
#import "SLCategoryViewModel.h"
#import "SLSiftView.h"
#import "SLCategoryRightTableView.h"
#import "SLCategoryLeftTableViewCell.h"

@interface SLCategoryVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)SLCategoryViewModel         *viewModel;

@property(nonatomic,strong)SLCategoryRightTableView    *rightTableView;

@property(nonatomic,strong)UITableView                  *leftTableView;

@property(nonatomic,strong)NSMutableArray               *leftDataArray;

@property(nonatomic,strong)NSMutableDictionary          *dataDic;

@property(nonatomic,strong)UIButton                     *rightBtn;

///筛选列表
@property(nonatomic,strong)SLSiftView                  *siftView;

///是否为第一次筛选（判断是否请求数据）
@property(nonatomic,assign)BOOL                         isFirstSift;
@end

@implementation SLCategoryVC
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)configSelf{
     self.isFirstSift = YES;
    [self.view addSubview:self.rightTableView];
    [self.view addSubview:self.leftTableView];
    self.leftTableView.dataSource       = self;
    self.leftTableView.delegate         = self;
    self.leftTableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    self.leftTableView.rowHeight        = 45;
    [self.leftTableView registerNib:[UINib nibWithNibName:@"SLCategoryLeftTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [self resetNavi];
    
    [self bindViewModel];
}

- (void)resetNavi
{
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:THEME_COLOR size:CGSizeMake(kWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
}

-(void)bindViewModel {
    [super bindViewModel];
    @weakify(self);
    [self.viewModel.refreshCommand execute:@[self.leftTableView,self.rightTableView]];
    //    RAC(self,dataDic)                   = RACObserve(self.viewModel, dataDic);
    //    绑定数据
    RAC(self,leftDataArray)             = RACObserve(self.viewModel, leftArray);
    RAC(_rightTableView,sectionArray)   = RACObserve(self.viewModel, leftArray);
    RAC(_rightTableView,dataDic)        = RACObserve(self.viewModel, dataDic);
    RAC(self.siftView,dataArray)        = RACObserve(self.viewModel, selectArray);
    
    
    self.rightTableView.mj_header       = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.refreshCommand execute:@[self.leftTableView,self.rightTableView]];
    }];
    //    右侧tableView滑动
    [self.viewModel.rightCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        NSIndexPath *indexPath = x;
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }];
    //    需要传值，所以不这样写
    //    RAC(self.rightBtn,rac_command)      = RACObserve(self.viewModel, selectedCommand);
    //    点击筛选按钮
    [[self.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self resetSiftView];
        if (self.isFirstSift)
        {
            [self.viewModel.selectedCommand execute:@[self.leftTableView,self.rightTableView,self.siftView]];
            self.isFirstSift = NO;
        }
    }];
    //    移除siftView
    [self.siftView.dismissSubject subscribeNext:^(id x) {
        //       消失
        @strongify(self);
        [self.viewModel beginDismissAnimation:@[self.leftTableView,self.rightTableView]];
    }];
}

- (void)resetSiftView
{
    if ([self.view viewWithTag:1111])
    {
        [self.siftView dismiss];
        [self.viewModel beginDismissAnimation:@[self.leftTableView,self.rightTableView]];
    }
    else
    {
        self.siftView.frame = CGRectMake(0 + kWidth, 0, kWidth, kHeight - 64 - 49);
        [self.view addSubview:self.siftView];
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:1
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.siftView.frame = CGRectMake(0, 0, kWidth, kHeight);
                         }
                         completion:^(BOOL finished) {
                         }];
        [self.viewModel beginShowAnimation:@[self.leftTableView,self.rightTableView]];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.rightTableView reloadData];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:THEME_COLOR size:CGSizeMake(kWidth, 64)] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:SLCOLOR(255, 255, 255, 0.99)] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel.leftClickCommand execute:@[self.rightTableView,indexPath]];
}

#pragma mark - tableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static BOOL isFirst = YES;
    SLCategoryLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.w_label.text = self.leftDataArray[indexPath.row];
    if(isFirst)
    {
        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
    isFirst = NO;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftDataArray.count;
}


#pragma mark - lazyLoad
- (SLCategoryRightTableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[SLCategoryRightTableView alloc]initWithFrame:CGRectMake(75, 0, kWidth - 75, kHeight - 49) style:UITableViewStylePlain];
        _rightTableView.viewModel = self.viewModel;
    }
    return _rightTableView;
}
- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 75, kHeight - 64 - 49) style:UITableViewStylePlain];
        _leftTableView.backgroundColor  = [UIColor clearColor];
    }
    return _leftTableView;
}
- (NSMutableArray *)leftDataArray
{
    if (!_leftDataArray)
    {
        _leftDataArray = [NSMutableArray array];
    }
    return _leftDataArray;
}

- (NSMutableDictionary *)dataDic
{
    if (!_dataDic)
    {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn)
    {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"w_shaixuan"] forState:UIControlStateNormal];
        _rightBtn.frame = CGRectMake(0, 0, 15, 15);
    }
    return _rightBtn;
}
- (SLSiftView *)siftView
{
    if (!_siftView)
    {
        _siftView = [[SLSiftView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64 - 49)];
        _siftView.tag = 1111;
    }
    return _siftView;
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
