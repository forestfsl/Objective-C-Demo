//
//  SLSetupViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLSetupViewModel.h"
#import "SLFunctionViewModel.h"
#import "SLPsdManagerViewModel.h"
#import "SLAboutMeView.h"

@implementation SLSetupViewModel
- (instancetype)initWithService:(id<SLViewModelServices>)service params:(NSDictionary *)params
{
    self = [super initWithService:service params:params];
    if (self)
    {
        [self initViewModel];
    }
    return self;
}

- (void)initViewModel
{
    self.cellClickSubject   = [RACSubject subject];
    [self.cellClickSubject subscribeNext:^(id x) {
        NSLog(@"%@",x);
        NSInteger tag = [x[0] integerValue];
        switch (tag)
        {
            case 0:
            {
                if ([[SLTool getCacheSize] floatValue] == 0)
                {
                    SHOW_ERROE(@"暂无要清除的内容");
                    DISMISS_SVP(1.2);
                }
                else
                {
                    [[SDWebImageManager sharedManager] cancelAll];
                    [[SDWebImageManager sharedManager].imageCache clearMemory];
                    [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:nil];
                    SHOW_SUCCESS(@"清除完成");
                    DISMISS_SVP(1.3);
                    UITableView *table = x[1];
                    [table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
                }
            }
                break;
            case 1:
            {
                //                功能
                SLFunctionViewModel *viewModel = [[SLFunctionViewModel alloc]initWithService:self.services params:@{@"title":@"功能"}];
                self.navImpl.className         = @"WTKFunctionVC";
                [self.navImpl pushViewModel:viewModel animated:YES];
            }
                break;
            case 2:
            {
                //                关于
                SLAboutMeView *aboutView       = [[SLAboutMeView alloc]initWithFrame:CGRectMake(kWidth / 6.0 , kHeight / 3.0, kWidth / 3.0 * 2.0, kWidth / 3.0 * 2.0 + 30) withTitleArray:@[@"确定"]];
                [[[UIApplication sharedApplication].delegate window] addSubview:aboutView];
            }
                break;
            case 3:
            {
                //                帮助中心
                
            }
                break;
            case 4:
            {
                //                密码管理
                SLPsdManagerViewModel *viewModel = [[SLPsdManagerViewModel alloc]initWithService:self.services params:@{@"title":@"密码修改"}];
                self.navImpl.className         = @"WTKPsdManagerVC";
                [self.navImpl pushViewModel:viewModel animated:YES];
            }
                break;
                
            default:
                break;
        }
        
        
    }];
    
    self.exitSubject        = [RACSubject subject];
    [self.exitSubject subscribeNext:^(id x) {
        UITableView *tableView = x;
        [SLTool exit];
        [tableView reloadData];
    }];
}


@end
