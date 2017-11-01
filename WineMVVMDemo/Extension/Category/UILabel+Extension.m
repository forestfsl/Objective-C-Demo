//
//  UILabel+Extension.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color {
    UILabel *label = [[UILabel alloc]init];
    label.font = font;
    label.textColor = color;
    label.text = text;
    
    return label;
}

-(void)configLabelWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)width cornerRadius:(CGFloat)radius isMask:(BOOL)isMask textAlignment:(NSTextAlignment)textAligment {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = isMask;
    self.textAlignment = textAligment;
}

-(void) setText:(NSString *)text Font:(UIFont *)font withColor:(UIColor *)color Range:(NSRange)range
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    self.attributedText = str;
}

-(void) setText:(NSString *)text Font:(UIFont *)font withColor:(UIColor *)color Range:(NSRange)range withColor:(UIColor *)color1 Range:(NSRange)range1
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    [str addAttribute:NSForegroundColorAttributeName value:color1 range:range1];
    [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    self.attributedText = str;
}

@end
