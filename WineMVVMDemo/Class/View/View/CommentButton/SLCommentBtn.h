//
//  SLCommentBtn.h
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLCommentBtn : UIButton

@property (nonatomic, strong) UIColor *titleColor;



/**
 返回一个自定义标题的按钮

 @param title 标题
 @param subTitle 子标题
 @return btn
 */
+ (instancetype)buttonWithTitle:(NSString *)title
                       subTitle:(NSString *)subTitle;

//重设title
- (void)setTitle:(NSString *)title
        subTitle:(NSString *)subTitle;

@end
