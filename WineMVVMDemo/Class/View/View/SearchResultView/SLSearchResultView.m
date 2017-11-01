//
//  SLSearchResultView.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLSearchResultView.h"
#import "SLSearchViewModel.h"
#import "SLHomeCell.h"
#import "SLGood.h"


@interface SLSearchResultView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource>
@property(nonatomic,strong)UICollectionView *collectionView;
///购物车
@property(nonatomic,strong)UIButton         *shoppingcarBtn;

@property(nonatomic,strong)UILabel          *bageLabel;

@property(nonatomic,assign)NSInteger        bageValue;

@end

@implementation SLSearchResultView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configInterface];
    }
    return self;
}

- (void)configSelf {
    
}

- (void)configSubView {
    [self setupCollectionView];
    [self setupShoppingCartBtn];
    [self setupBadgeLabel];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView             = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    self.collectionView.dataSource  = self;
    self.collectionView.delegate    = self;
    self.collectionView.emptyDataSetSource = self;
    _collectionView.backgroundColor = SLCOLOR(240, 240, 240, 1);
    [self.collectionView registerClass:[SLHomeCell class] forCellWithReuseIdentifier:@"search"];
    [self addSubview:self.collectionView];
}
- (void)setupShoppingCartBtn {
     @weakify(self);
    self.shoppingcarBtn.frame       = CGRectMake(kWidth - 80 * ZOOM_SCALL, kHeight - 80 * ZOOM_SCALL - 64, 60 * ZOOM_SCALL, 60 * ZOOM_SCALL);
    [self.shoppingcarBtn setBackgroundImage:[UIImage imageNamed:@"w_shoppingcar"] forState:UIControlStateNormal];
    [self addSubview:self.shoppingcarBtn];
    [[self.shoppingcarBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"TO3");
        [self.viewModel.shoppingCarCommand execute:@1];
    }];
}

- (void)setupBadgeLabel {
    self.bageLabel = [UILabel labelWithText:@"" font:[UIFont sl_NormalFont:12] textColor:[UIColor whiteColor]];
    self.bageLabel.backgroundColor  = [UIColor redColor];
    _bageLabel.textAlignment        = NSTextAlignmentCenter;
    _bageLabel.layer.cornerRadius   = 10;
    [self addSubview:_bageLabel];
    
    RAC(self,bageValue)  = RACObserve(CURRENT_USER, bageValue);
}

- (void)sl_reloadData{
    [self.collectionView reloadData];
}


#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel.goodCommand execute:self.dataArray[indexPath.row]];
}

#pragma mark - collectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"search" forIndexPath:indexPath];
    cell.isSearch = YES;
    SLGood *good = self.dataArray[indexPath.row];
    [cell configCellData:good];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kWidth - 30) / 2.0, (kWidth - 30) / 2.0 + 64);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark - DNZEmptyDataSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"暂时没搜到商品，您可以更换关键词试试"];
    [string addAttribute:NSForegroundColorAttributeName value:SLCOLOR(70, 70, 70, 1) range:NSMakeRange(0, 10)];
    
    return string;
}

#pragma mark - lazyLoad
- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[];
    }
    return _dataArray;
}
- (UIButton *)shoppingcarBtn
{
    if (!_shoppingcarBtn)
    {
        _shoppingcarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _shoppingcarBtn;
}
- (UILabel *)bageLabel
{
    if (!_bageLabel)
    {
        _bageLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth - 65 * ZOOM_SCALL - 12 * ZOOM_SCALL, kHeight - 64 - 65 * ZOOM_SCALL - 15 * ZOOM_SCALL, 20 * ZOOM_SCALL, 20 * ZOOM_SCALL)];
    }
    return _bageLabel;
}

@end
