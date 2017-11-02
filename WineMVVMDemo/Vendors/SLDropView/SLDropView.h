//
//  SLDropView.h
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLDropView : UIView

/**
 *  下拉菜单
 */

/**
 *   点击
 */
@property(nonatomic,strong)RACSubject *clickSubject;

@property(nonatomic,strong)RACSubject *dismissSubject;

/**
 *  设置背景图片
 */
@property(nonatomic,strong)UIImage *image;

/**
 *  构建方法
 *  param array   标题
 */
- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray<NSString *> *)array;
/**
 *  移除
 */
- (void)dismiss;

/**
 *  添加之后做动画
 */
- (void)beginAnimation;

@end
