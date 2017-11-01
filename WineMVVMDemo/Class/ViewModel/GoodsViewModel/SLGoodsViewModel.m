//
//  SLGoodsViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLGoodsViewModel.h"
#import "SLGood.h"
#import "SLShoppingCartViewModel.h"
#import "SLComment.h"



@interface SLGoodsViewModel ()
///当前选择的类型
@property(nonatomic,assign)NSInteger selectType;

@property(nonatomic,strong)NSArray *typeArray;

@property(nonatomic,strong)NSMutableDictionary *dataDic;

@end

@implementation SLGoodsViewModel

-(instancetype)initWithService:(id<SLViewModelServices>)service params:(NSDictionary *)params {
    if (self = [super initWithService:service params:params]) {
        self.selectType = 0;
        [self initViewModel];
    }
    return self;
}

- (void)initViewModel {
    // addCommand
    [self setupAddCommand];
    
    //clickShopCommand
    [self setupClickShopCommand];
    
    //sharedCommand
    [self setupAddSharedCommand];
    
    //refreshCommand
    [self setupRefreshCommand];
    
    //menuCommand
    [self setupMenuCommand];
}

- (void)setupMenuCommand {
    self.menuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        self.selectType = [input integerValue];
        if (self.dataDic[self.typeArray[self.selectType]])
        {///如果有，则不再请求
            self.commentArray = self.dataDic[self.typeArray[self.selectType]];
        }
        else
        {
            [self.refreshCommand execute:[[UITableView alloc]init]];
        }
        return [RACSignal empty];
    }];
}

- (void)setupRefreshCommand {
    self.refreshCommand  = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        SHOW_SVP(@"加载中");
        RACSignal *signal = [SLRequestManager  postDicDataWithURL:self.typeArray[self.selectType] parameter:@{}];
        [signal subscribeNext:^(id x) {
            [SVProgressHUD dismiss];
            self.titleDic = x[@"comment_count"];
            NSArray *array = x[@"comment_list"];
            NSMutableArray *mAarray = [NSMutableArray array];
            for (NSDictionary *aDic in array)
            {
                SLComment *comment = [[SLComment alloc]init];
                [comment setValuesForKeysWithDictionary:aDic];
                [mAarray addObject:comment];
            }
            self.dataDic[self.typeArray[self.selectType]] = mAarray;
            self.commentArray = mAarray;
            UITableView *tableView = input;
            if (tableView.mj_header.isRefreshing)
            {
                [tableView.mj_header endRefreshing];
            }
        }];
        return signal;
    }];
}

- (void)setupAddSharedCommand {
    
}
- (void)setupClickShopCommand {
    self.clickShopCommand   = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        self.navImpl.selectedIndex = 3;
        [self.navImpl popToRootViewModelWithAnimation:YES];
        return [RACSignal empty];
    }];
}

- (void)setupAddCommand {
    @weakify(self);
    self.addCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        NSLog(@"%@",input);
        [SLTool beginAddAnimationWithImageView:input animationTime:0.6 startPoint:CGPointMake(kWidth * 4 / 5, kHeight - 25) endPoint:CGPointMake(kWidth * 1.5 / 5, kHeight - 25)];
        [SLUser currentUser].bageValue ++;
        
        self.goods.num++;
        [[SLShoppingManager manager].goodsDic setObject:self.goods forKey:self.goods.id];
        
        return [RACSignal empty];
    }];
}

#pragma mark - lazyLoad

- (NSArray *)typeArray
{
    if (!_typeArray)
    {
        _typeArray = @[@"AllComment",@"GoodComment",@"MidComment",@"BadComment",@"PicComment"];
    }
    return _typeArray;
}
- (NSDictionary *)titleDic
{
    if (!_titleDic)
    {
        _titleDic = @{@"whole":@"0",
                      @"good":@"0",
                      @"middle":@"0",
                      @"bad":@"0",
                      @"picture":@"0"};
    }
    return _titleDic;
}
- (NSMutableArray *)commentArray
{
    if (!_commentArray)
    {
        _commentArray = @[].mutableCopy;
    }
    return _commentArray;
}
- (NSMutableDictionary *)dataDic
{
    if (!_dataDic)
    {
        _dataDic = @{}.mutableCopy;
    }
    return _dataDic;
}

@end
