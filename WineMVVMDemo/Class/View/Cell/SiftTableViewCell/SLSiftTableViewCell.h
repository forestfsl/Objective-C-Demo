//
//  SLSiftTableViewCell.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableViewCell.h"

@class SLSiftModel;
@interface SLSiftTableViewCell : SLBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *w_Label;

@property (weak, nonatomic) IBOutlet UIImageView *w_imageView;



@end
