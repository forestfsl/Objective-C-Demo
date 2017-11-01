//
//  SLAddress.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLAddress : NSObject
//名字
@property (nonatomic, copy) NSString *name;
//地址
@property (nonatomic, copy) NSString *address;
//手机号
@property (nonatomic, copy) NSString *phone;
//性别 YES-男 NO-女
@property (nonatomic, assign) BOOL sex;
//详细地址
@property (nonatomic, copy) NSString *detailAddress;

@end
