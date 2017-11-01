//
//  SLBaseView.h
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLBaseView : UIView

- (void)configInterface;


- (void) create;

- (void)configSelf;

- (void)configSubView;

- (void)configConstraint;

- (void)configViewData:(id)obj;

@end
