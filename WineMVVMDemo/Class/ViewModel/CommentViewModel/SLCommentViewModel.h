//
//  SLCommentViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"
@class SLOrderModel;
@class SLCommentVC;
@interface SLCommentViewModel : SLBaseViewModel

@property(nonatomic,strong)SLOrderModel    *order;

@property(nonatomic,weak)SLCommentVC       *vc;

@property(nonatomic,strong)RACCommand       *addPicCommand;

@property(nonatomic,strong)RACCommand       *commitCommand;

@property(nonatomic,strong)RACSubject       *changeImgSubject;

///评论
@property(nonatomic,copy)NSString           *comment;

@end
