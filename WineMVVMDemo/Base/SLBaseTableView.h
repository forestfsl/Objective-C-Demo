//
//  SLBaseTableView.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLBaseTableView : UITableView

- (void)configInterface;

- (void) create;

- (void)configSelf;

- (void)configSubView;

- (void)configConstraint;

- (void)configTableViewData:(id)obj;

@end
