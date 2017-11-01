//
//  SLCommentTableView.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLCommentTableView.h"
#import "SLCommentTableViewCell.h"
#import "SLComment.h"

@interface SLCommentTableView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)NSMutableDictionary *heightDic;

@property(nonatomic,strong)UIView               *headerView;

@end

@implementation SLCommentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self configInterface];
    }
    return self;
}

- (void)configSelf {
    self.dataSource     = self;
    self.delegate       = self;
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerClass:[SLCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    [self reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    SLComment *commment = self.dataArray[indexPath.row];
    [cell configCellData:commment];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    SLComment *comment = self.dataArray[indexPath.row];
    height = [SLTool calculateStringHeight:comment.content withFont:[UIFont sl_NormalFont:16] stringWidth:kWidth - 30] + 215;
    if (comment.content.length <= 0)
    {
        height = 215;
    }
    if (comment.pic_path.count > 0)
    {
        height = [SLTool calculateStringHeight:comment.content withFont:[UIFont sl_NormalFont:16] stringWidth:kWidth - 30] + 285;
    }
    
    
    return height;
}

#pragma mark - DZNEmptyData

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    [[SLNetWorkManager shareInatance] initNetWork];
    if ([SLNetWorkManager shareInatance].isNetReachable)
    {
        return [UIImage imageNamed:@"NotWorkViews"];
    }
    return [UIImage imageNamed:@"w_no_msg"];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    [[SLNetWorkManager shareInatance] initNetWork];
    if ([SLNetWorkManager shareInatance].isNetReachable)
    {
        return [[NSAttributedString alloc]initWithString:@""];
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"还没有评论哦"];
    [string addAttribute:NSForegroundColorAttributeName value:SLCOLOR(70, 70, 70, 1) range:NSMakeRange(0, 6)];
    
    return string;
}

#pragma mark - lazyLoad

- (NSMutableDictionary *)heightDic
{
    if (!_heightDic)
    {
        _heightDic = @{}.mutableCopy;
    }
    return _heightDic;
}

@end
