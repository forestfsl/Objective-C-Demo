//
//  SLOrderDetailModel.h
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLOrderDetailModel : NSObject

@property (nonatomic,strong)NSString *avatar_url;

@property (nonatomic,strong)NSString *integral;

@property (nonatomic,strong)NSString *order_id;

@property (nonatomic,assign)float price;

@property (nonatomic,strong)NSString *qrcode;

@property (nonatomic,assign)int quantity;

@property (nonatomic,strong)NSString *specification;

@property (nonatomic,strong)NSString *title;

@property (nonatomic,strong)NSString *ordercompleted_id;

@property (nonatomic, assign) BOOL is_gift;

@property (nonatomic, assign) NSInteger purchasePrice;

@property (nonatomic, copy) NSString* product_id;

@end
