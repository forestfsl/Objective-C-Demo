//
//  UIColor+Extension.h
//  WineMVVMDemo
//
//  Created by songlin on 28/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 * 十六进制颜色值
 */
+(UIColor *) colorWithHex:(long)hex;
+(UIColor *) colorWithHexString:(NSString *)hex;

+(UIColor *) colorWithHex:(long)hex alpha:(float)alpha;

@end
