//
//  SLGood.h
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLGood : NSObject<NSCoding>

//商品的图片地址
@property (nonatomic, copy) NSString *avatar_url;

//类别
@property (nonatomic, copy) NSString *category_name;

//商品编号
@property (nonatomic, copy) NSString *id;

//市场价格
@property (nonatomic, assign) double marketPrice;

//价格
@property (nonatomic, assign) double price;

//二维码
@property (nonatomic, strong) NSString *qrcode;

//获取商品的销量
@property (nonatomic, assign) int sale_count;

//规格重量
@property (nonatomic, copy) NSString *specification;

//状态
@property (nonatomic, copy) NSString *state;

//库存
@property (nonatomic, assign) NSInteger stock;

//标签
@property (nonatomic, assign) int tag;

//商品缩略图
@property (nonatomic, strong) NSString *thumb_url;

//商品名称
@property (nonatomic, copy) NSString *title;

//添加到购物车数量
@property (nonatomic, assign) NSInteger num;

//购物车是否选择
@property (nonatomic, assign) BOOL w_isSelected;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
