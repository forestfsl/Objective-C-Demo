//
//  SLUser.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLAddress.h"

@interface SLUser : NSObject

///头像
@property(nonatomic,strong)UIImage          *headImage;
///昵称
@property(nonatomic,copy)NSString           *nickName;
///名字
@property(nonatomic,copy)NSString           *userName;

///性别 YES-男 NO-女
@property(nonatomic,assign)BOOL             sex;

@property(nonatomic,copy)NSString           *birthDay;
///是否开启指纹验证
@property(nonatomic,assign)BOOL             isTouchID;

///角标
@property(nonatomic,assign)NSInteger        bageValue;


@property(nonatomic,copy)NSString           *bid;

///是否登录
@property(nonatomic,assign)BOOL             isLogin;
///手机号
@property(nonatomic,copy)NSString           *phoneNum;

///是否开启声音
@property(nonatomic,assign)BOOL             isSound;

///是否开启震动
@property(nonatomic,assign)BOOL             isShake;

///是否夜间模式
@property(nonatomic,assign)BOOL             isNight;

///密码
@property(nonatomic,copy)NSString           *password;

///地址
@property(nonatomic,strong)NSMutableArray<SLAddress *>   *address;

///默认地址
@property(nonatomic,strong) SLAddress       *defaultAddress;
///城市
@property(nonatomic,copy) NSString           *city;
///定位地址
@property(nonatomic,strong) NSDictionary     *currentAddress;




+ (instancetype)currentUser;

@end
