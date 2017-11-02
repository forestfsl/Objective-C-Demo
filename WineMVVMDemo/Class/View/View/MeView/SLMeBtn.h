//
//  SLMeBtn.h
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLMeBtn : UIButton
/**
 *  左上的提示
 */
@property(nonatomic,assign)NSInteger bageValue;
/**
 * 构建方法  最低高度65
 */
+ (instancetype)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName;
@end
