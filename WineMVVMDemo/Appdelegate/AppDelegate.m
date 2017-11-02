//
//  AppDelegate.m
//  WineMVVMDemo
//
//  Created by songlin on 28/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "AppDelegate.h"
#import "SLTabbarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    SLTabbarViewController *rootTab = [SLTabbarViewController sharedInstance];
    self.window.rootViewController = rootTab;
    
    //读取缓存数据
//    [SLDataManager readUserData];
    
    [self setupMapManager];
    return YES;
}

//初始化MapManager
- (void)setupMapManager {
    BMKMapManager *mapManager           = [[BMKMapManager alloc]init];
    if ([mapManager start:@"MoboTBCXuQbImL0wfRSCtyHAjk9j6prp" generalDelegate:nil])
    {
        NSLog(@"百度地图startSuccess");
        //        开始定位
        [[SLMapManager manager] startUserLocation];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [SLDataManager saveUserData];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [SLDataManager saveUserData];
}


@end
