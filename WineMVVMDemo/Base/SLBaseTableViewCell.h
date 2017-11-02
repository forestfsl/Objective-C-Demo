//
//  SLBaseTableViewCell.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLBaseTableViewCell : UITableViewCell


//配置借口数据
- (void)configInterface;
//配置cellData,通过模型
- (void)configCellData:(id)obj;
- (void)configCellTitle:(NSString *)title subTitle:(NSString *)subTitle;

//配置Cell自身属性
- (void)configSelf;
//配置Cell的subView
- (void)configSubView;
//配置Cell的相关约束
- (void)configConstraint;
@end
