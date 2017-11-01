//
//  SLTabbarViewController.h
//  WineMVVMDemo
//
//  Created by songlin on 28/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SLTabbarViewController : UITabBarController

+ (instancetype)sharedInstance;

- (instancetype)init __attribute__((unavailable("init is not avaiable in RootTabBarController, Use sharedInstance")));





@end
