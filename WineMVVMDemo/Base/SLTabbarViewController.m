//
//  SLTabbarViewController.m
//  WineMVVMDemo
//
//  Created by songlin on 28/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLTabbarViewController.h"
#import "SLNavigationViewController.h"
#import "SLBaseViewController.h"
#import "SLHomeViewModel.h"

@interface SLTabbarViewController ()

@property(nonatomic,strong)UIImageView *launchImage;
@end

@implementation SLTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLaunch];
    [self addChildVC];
    [self observerBadgeValue];
    //监听读取用户数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readDataFinish) name:READ_USER_DATA_FINISH object:nil];
}

- (void)setLaunch
{
#warning 以后修改launchImage  名字
    self.launchImage        = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.launchImage.image  = [UIImage imageNamed:@"top_launch"];
    self.launchImage.tag    = 111;
    [self.view addSubview:self.launchImage];
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self endLaunch];
    });
    UIButton *btn           = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame               = CGRectMake(kWidth - 80, 30, 60, 25);
    btn.backgroundColor     = SLCOLOR(30, 30, 30, 0.7);
    btn.titleLabel.font     = [UIFont sl_NormalFont:14];
    btn.layer.cornerRadius  = 8;
    btn.layer.masksToBounds = YES;
    btn.tag                 = 222;
    [btn setTitle:@"跳过" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(endLaunch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.view.backgroundColor = THEME_COLOR;
}

- (void)endLaunch
{
    if (![self.view viewWithTag:111])
    {
        return;
    }
    UIView *btn = [self.view viewWithTag:222];
    if (btn)
    {
        [btn removeFromSuperview];
    }
    @weakify(self);
    [UIView animateWithDuration:1.3 animations:^{
        @strongify(self);
        self.launchImage.transform  = CGAffineTransformMakeScale(1.3, 1.3);
        self.launchImage.alpha      = 0;
    } completion:^(BOOL finished) {
        [self.launchImage removeFromSuperview];
    }];
}
//读取本地数据
- (void)readDataFinish
{
    if (![SLUser currentUser].isTouchID)
    {
        [SLTool registTouchIDWithCompleteBlock:^(NSString *tip) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if ([tip isEqualToString:@"不支持指纹验证"])
                {
                    return ;
                }
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:tip preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }];
    }

    
    
    
}
///监听badgeValue
- (void)observerBadgeValue
{
    @weakify(self);
    [RACObserve([SLUser currentUser], bageValue) subscribeNext:^(id x) {
        @strongify(self);
        UIViewController *vc = self.viewControllers[3];
        NSInteger num = [x integerValue];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (num > 0)
            {
                [vc.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld",num]];
            }
            else
            {
                [vc.tabBarItem setBadgeValue:nil];
            }
        });
        
    }];
}

- (void)addChildVC {
    NSDictionary *tabbarDict = [SLJsonHelper fromResource:@"menu.json" ofType:nil];
    NSArray *dictArray = tabbarDict[@"tabbar_items"];
    for (NSDictionary *dict in dictArray) {
        NSString *vcName = dict[@"page"];
        NSString *vcTitle = dict[@"title"];
        NSString *imageName = dict[@"normal_icon"];
        NSString *modelType = dict[@"modelType"];
        [self addChildVCWithName:vcName title:vcTitle imageName:imageName modelType:modelType];;
    }
}

- (void)addChildVCWithName:(NSString *)name title:(NSString *)title imageName:(NSString *)imageName modelType:(NSString *)modelType{
//    NSString *namespace = [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
//    namespace = [namespace stringByAppendingString:@"."];
//    NSString *clsName = [namespace stringByAppendingFormat:@"%@",name];
      Class vcClass = NSClassFromString(name);
      Class viewModelClass = NSClassFromString(modelType);
      SLBaseViewModel *baseViewModel = [[viewModelClass alloc]initWithService:nil params:@{@"title":title}];
        SLBaseViewController *VC = [[vcClass alloc]initWithViewModel:baseViewModel];
    
        VC.title = title;
        VC.tabBarItem.image = [UIImage imageNamed:imageName];
        imageName = [imageName stringByAppendingString:@"_"];
        VC.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"select"]];
        NSDictionary *normal = @{NSForegroundColorAttributeName:BLACK_COLOR,NSFontAttributeName:FONT12};
        [VC.tabBarItem setTitleTextAttributes:normal forState:UIControlStateNormal];
        NSDictionary *selectDict = @{NSForegroundColorAttributeName:THEME_COLOR,NSFontAttributeName:FONT12};
        [VC.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected];
        
        SLNavigationViewController *nav = [[SLNavigationViewController alloc]initWithRootViewController:VC];
        [self addChildViewController:nav];
}

+ (instancetype)sharedInstance {
    static SLTabbarViewController *sharedInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
 
}


@end
