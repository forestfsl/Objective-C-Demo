//
//  SLQRCode.h
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SLCodeType) {
    SLCodeTypeQRCode = 0,
    SLCodeTypeCode,
};

@interface SLQRCode : NSObject


//构建方法
+ (instancetype)shareInstance;
/**
 *  创建二维码
 *  @param message  二维码信息
 *  @param size     要返回的图片大小
 */
+ (UIImage *)buildQRCodeWithMessage:(NSString *)message
                       codeType:(SLCodeType)type
                           size:(CGSize)size;
/**
 *  扫描二维码
 *  @param vc       在那个viewController上面展示
 *  @param view     遮罩 (中间的框框)
 *  @param lineView 线
 *  @param completeBlock 完成时的回调
 */
+ (void)scanWithVC:(UIViewController *)vc
        scanView:(UIView *)view
        lineView:(UIView *)lineView
   completeBlock:(void(^)(NSString *result))completeBlock;

///结束
+ (void)endScan;



@end
