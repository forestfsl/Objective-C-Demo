//
//  UIFont+Extension.m
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)

+(UIFont *)sl_NormalFont:(CGFloat)size {
    if (kWidth == 320 || kWidth == 640)
    {
        return [UIFont systemFontOfSize:size - 1];
    }
    else if (kWidth == 375 || kWidth == 750)
    {
        return [UIFont systemFontOfSize:size];
    }
    else
    {
        return [UIFont systemFontOfSize:size + 1];
    }
}

+ (UIFont *)sl_BlodFont:(CGFloat)size {
    if (kWidth == 320 || kWidth == 640)
    {
        return [UIFont boldSystemFontOfSize:size - 1];
    }
    else if (kWidth == 375 || kWidth == 750)
    {
        return [UIFont boldSystemFontOfSize:size];
    }
    else
    {
        return [UIFont boldSystemFontOfSize:size + 1];
    }
}

@end
