//
//  SLAddressTableViewCell.h
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseTableViewCell.h"

@interface SLAddressTableViewCell : SLBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *w_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *w_phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *w_addresslabel;

@property(nonatomic,strong)RACSubject   *subject;

@end
