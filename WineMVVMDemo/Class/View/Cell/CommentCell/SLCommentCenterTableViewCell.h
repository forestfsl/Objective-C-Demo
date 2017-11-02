//
//  SLCommentCenterTableViewCell.h
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableViewCell.h"
@class SLOrderModel;

@interface SLCommentCenterTableViewCell : SLBaseTableViewCell
///评价
@property(nonatomic,strong)RACSubject *commentSubject;

@end
