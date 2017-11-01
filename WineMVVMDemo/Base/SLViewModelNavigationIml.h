//
//  SLViewModelNavigationIml.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLViewModelNavigationIml : NSObject<SLViewModelServices>
@property (nonatomic, copy) NSString *className;

//设置当前rootVC
@property (nonatomic, assign) NSInteger selectedIndex;
- (instancetype)initWithNavigationController:(UINavigationController *)navi;


@end
