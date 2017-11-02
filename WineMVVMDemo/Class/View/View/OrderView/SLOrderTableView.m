//
//  SLOrderTableView.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLOrderTableView.h"
#import "SLOrderTableViewCell.h"
#import "SLOrderViewModel.h"

@interface SLOrderTableView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>



@end

@implementation SLOrderTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self configInterface];
    }
    return self;
}

- (void)configSelf {
    self.dataSource         = self;
    self.delegate           = self;
    [self registerNib:[UINib nibWithNibName:@"SLOrderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.separatorStyle     = UITableViewCellSeparatorStyleNone;
    
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    [self reloadData];
    
}
#pragma mark - dataSource
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell configCellData:self.dataArray[indexPath.row]];
//    cell.order                  = self.dataArray[indexPath.row];
    cell.selectionStyle         = UITableViewCellSelectionStyleNone;
    UIView *view                = [cell viewWithTag:10000];
    if (indexPath.row == self.dataArray.count - 1)
    {
        if(!view)
        {
            view                = [[UIView alloc]initWithFrame:CGRectMake(0, 170, kWidth, 15)];
            view.tag            = 10000;
            view.backgroundColor= SLCOLOR(242, 242, 242, 1);
            [cell addSubview:view];
        }
        view.hidden             = NO;
        
    }
    else
    {
        if (view)
        {
            view.hidden         = YES;
        }
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArray.count -1)
    {
        return 185;
    }
    return 170;
}

#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.viewModel.cellClickCommand execute:self.dataArray[indexPath.row]];
}


#pragma mark - DZNDelegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.mj_header.isRefreshing) {
        return nil;
    }
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"暂无订单"];
    [text addAttribute:NSFontAttributeName value:[UIFont sl_NormalFont:24] range:NSMakeRange(0, 4)];
    
    return text;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.mj_header.isRefreshing) {
        return nil;
    }
    return [UIImage imageNamed:@"w_no_order"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    
    [self.mj_header beginRefreshing];
}


@end
