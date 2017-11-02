//
//  SLAddressTableViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLAddressTableViewCell.h"
#import "SLAddress.h"

@interface SLAddressTableViewCell ()

@property (nonatomic, strong) SLAddress *address;
@end

@implementation SLAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.subject = [RACSubject subject];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configCellData:(id)obj {
    self.address = (SLAddress *)obj;
    self.w_nameLabel.text   = self.address.name;
    self.w_phoneLabel.text  = self.address.phone;
    self.w_addresslabel.text= self.address.address;
}
- (IBAction)editBtnClick:(id)sender {
    [self.subject sendNext:@{@"code":@100,@"address":self.address}];
}
- (IBAction)deleteBtnClick:(id)sender {
    [self.subject sendNext:@{@"code":@-100,@"address":self.address}];
}

@end
