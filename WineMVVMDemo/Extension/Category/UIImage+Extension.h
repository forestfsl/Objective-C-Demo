//
//  UIImage+Extension.h
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 UIImage
 @return 根据颜色和size生成图片
 */

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 根据颜色生成图片

 @param color color
 @return UIImage
 */
+ (UIImage *)imageFromColor:(UIColor *)color;

//毛玻璃
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

//返回一张自由调整大小的图片
+(UIImage *)newImageWithNamed:(NSString *)name
                         size:(CGSize)size;

///修正图片方向（从照片，相机获取的）
+(UIImage *)fixOrientation:(UIImage *)aImage;
@end
