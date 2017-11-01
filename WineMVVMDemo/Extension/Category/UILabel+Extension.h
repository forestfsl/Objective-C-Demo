//
//  UILabel+Extension.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)


/**
 类方法创建label

 @param text 文字内容
 @param font 字体大小
 @param color 颜色
 @return UILabel
 */
+ (UILabel *)labelWithText:(NSString *)text
                      font:(UIFont *)font
                 textColor:(UIColor *)color;


/**
 配置label的圆角相关属性

 @param borderColor 边框yans
 @param width 边框宽度
 @param radius 边框弧度
 @param isMask 是否mask
 @param textAligment 对齐方式，默认NSTextAlignmentNatural
 */
- (void)configLabelWithBorderColor:(UIColor *)borderColor
                       borderWidth:(CGFloat)width
                      cornerRadius:(CGFloat)radius
                            isMask:(BOOL)isMask
                     textAlignment:(NSTextAlignment)textAligment;


-(void) setText:(NSString *)text Font:(UIFont *)font withColor:(UIColor *)color Range:(NSRange)range;

-(void) setText:(NSString *)text Font:(UIFont *)font withColor:(UIColor *)color Range:(NSRange)range withColor:(UIColor *)color1 Range:(NSRange)range1;
@end
