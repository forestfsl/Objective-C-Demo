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

@end

@implementation SLTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildVC];
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



@end
