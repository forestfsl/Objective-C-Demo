//
//  Macro.h
//  OCDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#ifndef Macro_h
#define Macro_h


//Marco
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define SLLog(fmt,...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]" "[行号:%d] \n" fmt),__FILE__,__FUNCTION__,__LINE__,##__VA_ARGS__);
#else
#define NSLog(...) {}
#define SLLog(...);
#endif

//UIColor
#define SLCOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define BASE_COLOR SLCOLOR(243, 243, 246, 1.0)

#define BACK_COLOR SLCOLOR(240,240,240,1)


#define BASE_COLOR1 SLCOLOR(210, 210, 210, 1.0)

#define THEME_COLOR SLCOLOR(250, 98, 97, 1)

#define THEME_COLOR_ALPHA SLCOLOR(250, 98, 97, 0.99)

#define BLACK_COLOR SLCOLOR(50,50,50,1)

#define WORDS_COLOR [UIColor colorWithHex:0x5c5c5c] // 常规文字

#define LINKS_COLOR [UIColor colorWithHex:0x333333] // 链接 (深绿)

#define LINE_COLOR [UIColor colorWithHex:0xe9e9e9]  // 描线色


//UIFont
#define SLFONT(fontSize) [UIFont systemFontOfSize:fontSize]

#define FONT12 SLFONT(12)
#define FONT14 SLFONT(14)


///SVP
#define SHOW_SVP(title) \
[SVProgressHUD showWithStatus:title];

#define SHOW_ERROE(title) \
[SVProgressHUD showErrorWithStatus:title];

#define SHOW_SUCCESS(title) \
[SVProgressHUD showSuccessWithStatus:title];

#define DISMISS_SVP(time) \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
[SVProgressHUD dismiss]; \
});


//NSUserDefaults
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define CURRENT_USER [SLUser currentUser]


#pragma mark - 宽高

#define kHeight [[UIScreen mainScreen] bounds].size.height
#define kWidth [[UIScreen mainScreen] bounds].size.width
#define ZOOM_SCALL kWidth/375.0

//图片url
#define IMG_URL @"http://www.jiuyunda.net:90"

//SystemVersion
// 系统版本浮点型
#define kSystemVersionF [[[UIDevice currentDevice] systemVersion] floatValue]
// 系统版本字符串类型
#define kSystemVersion [[UIDevice currentDevice] systemVersion]


//URL Macro
//首页轮播图
#define HOME_HEAD @"HomeHead"
//首页热门商品
#define Home_Data @"HomeData"

#endif /* Macro_h */
