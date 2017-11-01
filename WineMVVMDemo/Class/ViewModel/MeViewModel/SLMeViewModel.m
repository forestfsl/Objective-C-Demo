//
//  SLMeViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLMeViewModel.h"
#import "SLOrderViewModel.h"
#import "SLRecommendViewModel.h"
#import "SLLoginViewModel.h"
#import "SLSetupViewModel.h"
#import "SLFeedBackViewModel.h"
#import "SLWebViewModel.h"
#import "SLAboutMeViewModel.h"
#import "SLCommentCenterViewModel.h"


@implementation SLMeViewModel

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
    
    self.setUpSubject       = [RACSubject subject];
    [self.setUpSubject subscribeNext:^(id x) {
        NSLog(@"shezhi");
        SLSetupViewModel *viewModel    = [[SLSetupViewModel alloc]initWithService:self.services params:@{@"title":@"设置"}];
        self.navImpl.className         = @"SLSetUpVC";
        [self.navImpl pushViewModel:viewModel animated:YES];
    }];
    
    self.cellClickSubject   = [RACSubject subject];
    [self.cellClickSubject subscribeNext:^(id x) {
        NSLog(@"cell点击%@",x);
        NSInteger num = [x integerValue];
        switch (num) {
            case 0:
            {
                //                全部订单
                SLOrderViewModel *viewModel = [[SLOrderViewModel alloc]initWithService:self.services params:@{@"title":@"全部订单"}];
                viewModel.orderType = 0;
                self.navImpl.className = @"SLOrderVC";
                [self.navImpl pushViewModel:viewModel animated:YES];
            }
                break;
            case 1:
            {
                //                钱包查看明细
                [SVProgressHUD showImage:[UIImage imageNamed:@"w_error"] status:@"敬请期待"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
                break;
            case 2:
            {
                //                推荐有奖
                SLRecommendViewModel *viewModel    = [[SLRecommendViewModel alloc]initWithService:self.services params:@{@"title":@"推荐有奖"}];
                self.navImpl.className             = @"SLRecommendVC";
                [self.navImpl pushViewModel:viewModel animated:YES];
            }
                break;
            case 3:
            {
                //                意见反馈
                SLFeedBackViewModel *viewModel     = [[SLFeedBackViewModel alloc]initWithService:self.services params:@{@"title":@"意见反馈"}];
                self.navImpl.className             = @"SLFeedbackVC";
                [self.navImpl pushViewModel:viewModel animated:YES];
            }
            case 4:
            {
                //                客服热线
                
            }
                break;
            case 5:
            {
                //                酒运达
                SLWebViewModel *viewModel  = [[SLWebViewModel alloc]initWithService:self.services params:@{@"title":@"酒运达"}];
                viewModel.urlString         = @"http://a.eqxiu.com/s/dH91BoVd";
                self.navImpl.className     = @"SLWebVC";
                [self.navImpl pushViewModel:viewModel animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
    
    self.headClickSubject = [RACSubject subject];
    [self.headClickSubject subscribeNext:^(id x) {
        NSLog(@"head点击%@",x);
        NSInteger num = [x integerValue];
        switch (num) {
            case 4:
            {
                //                积分
                SHOW_ERROE(@"敬请期待");
                DISMISS_SVP(1.2);
            }
                break;
            case 5:
            {
                //                酒库
                SHOW_ERROE(@"敬请期待");
                DISMISS_SVP(1.2);
            }
                break;
            case 6:
            {
                //                优惠券
                SHOW_ERROE(@"敬请期待");
                DISMISS_SVP(1.2);
            }
                break;
            case 7:
            {
                //                酒券
                SHOW_ERROE(@"敬请期待");
                DISMISS_SVP(1.2);
            }
                break;
            case 8:
            {
                //                点击头像
                if ([self judgeWhetherLogin:YES])
                {
                    NSLog(@"YES");
                    SLAboutMeViewModel *viewModel = [[SLAboutMeViewModel alloc]initWithService:self.services params:@{@"title":@"我的信息"}];
                    self.navImpl.className = @"SLAboutMeVC";
                    [self.navImpl pushViewModel:viewModel animated:YES];
                }
                else
                {
                    NSLog(@"no");
                }
            }
                break;
            case 9:
            {
                //                收藏
            }
                break;
            case 10:
            {
                //                足迹
            }
                break;
                
            default:
            {
                //                订单
                NSArray *arr = @[@"待支付",@"配送中",@"待配送",@"待评价"];
                if (num == 3)
                {
                    SLCommentCenterViewModel *viewModel = [[SLCommentCenterViewModel alloc]initWithService:self.services params:@{@"title":@"评价中心"}];
                    self.navImpl.className = @"SLCommentCenterVC";
                    [self.navImpl pushViewModel:viewModel animated:YES];
                }
                else
                {
                    SLOrderViewModel *viewModel = [[SLOrderViewModel alloc]initWithService:self.services params:@{@"title":arr[num]}];
                    viewModel.orderType = num + 1;
                    self.navImpl.className = @"SLOrderVC";
                    [self.navImpl pushViewModel:viewModel animated:YES];
                }
                
            }
                break;
        }
    }];
}

@end
