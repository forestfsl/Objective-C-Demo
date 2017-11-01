//
//  SLCommentTableViewCell.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLCommentTableViewCell.h"
#import "SLComment.h"
#import "SLStarView.h"

@interface SLCommentTableViewCell ()

///头像
@property(nonatomic,strong)UIImageView      *headImg;
///名字
@property(nonatomic,strong)UILabel          *nameLabel;
///评论日期
@property(nonatomic,strong)UILabel          *commentTime;

///购买日期
@property(nonatomic,strong)UILabel          *orderTime;

///评论
@property(nonatomic,strong)UILabel          *commentLabel;

///购买日期
@property(nonatomic,strong)UILabel          *spec;
///星级
@property(nonatomic,strong)SLStarView      *starView;

@property (nonatomic, strong) UIView *bottomView;

@property(nonatomic,strong)UIScrollView     *picScrollView;

@property(nonatomic,strong)SLComment       *comment;

///晒图
@property(nonatomic,strong)NSMutableArray   *imgArray;

@end

@implementation SLCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configInterface];
    }
    return self;
}

- (void)configCellData:(id)obj
{
    SLComment *comment = (SLComment *)obj;
    WS(weakSelf);
    self.comment                = comment;
    self.nameLabel.text       = comment.name;
    self.orderTime.text       = [NSString stringWithFormat:@"购买日期：%@",comment.order_completed_time];
    self.commentTime.text     = comment.created_at_str;
    self.commentLabel.text         = comment.content;
    self.starView.star        = comment.star;
    self.spec.text            = [NSString stringWithFormat:@"规格：%@",comment.specification];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:comment.avatar_url] placeholderImage:[UIImage imageNamed:@"w_defaultHeader"]];
    if (comment.pic_thumb_path.count > 0)
    {
        [self.picScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10);
            make.right.equalTo(weakSelf).offset(10);
            make.bottom.equalTo(weakSelf.spec.mas_top).offset(-10);
            make.height.mas_equalTo(70);
        }];
        [comment.pic_thumb_path enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (self.imgArray.count > idx)
            {
                UIImageView *imageView = self.imgArray[idx];
                imageView.frame = CGRectMake(0, idx * 70, 70, 70);
                [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:[UIImage imageNamed:@"placehoder2"]];
                [weakSelf.picScrollView addSubview:imageView];
            }
            else
            {
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, idx * 70, 70, 70)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:[UIImage imageNamed:@"placehoder2"]];
                [weakSelf.picScrollView addSubview:imageView];
            }
        }];
        self.picScrollView.contentSize = CGSizeMake(70 * comment.pic_thumb_path.count, 70);
    }
    else
    {
        [self.picScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10);
            make.right.equalTo(weakSelf).offset(10);
            make.bottom.equalTo(weakSelf.spec.mas_top).offset(0.01);
            make.height.mas_equalTo(0.01);
        }];
        for (UIView *view in self.picScrollView.subviews)
        {
            [view removeFromSuperview];
        }
    }
    
}

- (void)configSelf {
     self.backgroundColor        = SLCOLOR(253, 253, 253, 1);
    self.starView.layer.cornerRadius = 25;
    self.starView.layer.masksToBounds = YES;
}


- (void)configConstraint {
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImg);
        make.left.equalTo(self.headImg.mas_right).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    
    [self.commentTime  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self.headImg);
        make.left.equalTo(self.nameLabel.mas_right);
        make.height.mas_equalTo(25);
    }];
    
  
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.headImg.mas_bottom).offset(12);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(20);
    }];
    
    [self.orderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self.bottomView.mas_top).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.spec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self.orderTime.mas_top).offset(-5);
        make.height.mas_equalTo(20);
    }];
    [self.picScrollView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(10);
        make.bottom.equalTo(self.spec.mas_top).offset(-10);
        make.height.mas_equalTo(70);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starView.mas_bottom).offset(10);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self.picScrollView.mas_top).offset(-10);
    }];
}


- (void)configSubView
{
    [self setupHeadImage];
    
    [self setupNameLabel];
   
    [self setupCommentTime];
    
    [self setupStarView];
    
    [self setupBottomView];
    
    [self setupOrderTime];
   
    [self setupSpec];
    
    [self setupPicScroll];
    
    [self setupCommentLabel];
    
}

- (void)setupCommentLabel {
    self.commentLabel                  = [[UILabel alloc]init];
    self.commentLabel .textColor        = SLCOLOR(70, 70, 70, 1);
    self.commentLabel .font             = [UIFont sl_NormalFont:16];
    self.commentLabel .numberOfLines    = 0;
    [self addSubview:self.commentLabel];
}

- (void)setupPicScroll {
    self.picScrollView            = [[UIScrollView alloc]init];
    [self addSubview:self.picScrollView ];
}
- (void)setupSpec {
    self.spec                     = [[UILabel alloc]init];
    self.spec.textColor           = self.nameLabel.textColor;
    self.spec.font                = [UIFont sl_NormalFont:14];
    [self addSubview:self.spec];
    
}

- (void)setupOrderTime {
    self.orderTime                = [[UILabel alloc]init];
    self.orderTime.textColor      = self.nameLabel.textColor;
    self.orderTime.font           = [UIFont sl_NormalFont:14];
    [self addSubview:self.orderTime];
    
}

- (void)setupBottomView {
    self.bottomView          = [[UIView alloc]init];
    self.bottomView .backgroundColor  = SLCOLOR(230, 230, 230, 1);
    [self addSubview:self.bottomView ];
    
}
- (void)setupHeadImage {
    self.headImg              = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"w_defaultHeader"]];
    
    [self addSubview:self.headImg];
}
- (void)setupNameLabel {
    self.nameLabel                = [[UILabel alloc]init];
    self.nameLabel.textColor      = SLCOLOR(120, 120, 120, 1);
    self.nameLabel.font           = [UIFont sl_NormalFont:16];
    [self addSubview:self.nameLabel];
}

- (void)setupCommentTime {
    self.commentTime              = [[UILabel alloc]init];
    self.commentTime .textColor    = SLCOLOR(100, 100, 100, 1);
    self.commentTime .font         = [UIFont sl_NormalFont:14];
    self.commentTime .textAlignment= NSTextAlignmentRight;
    [self addSubview:self.commentTime ];
}
- (void)setupStarView {
    self.starView                 = [[SLStarView alloc]initWithFrame:CGRectMake(10, 70, 100, 20) starSize:CGSizeZero withStyle:SLStarTypeInteger];
    [self addSubview:self.starView];
}

- (NSMutableArray *)imgArray
{
    if (!_imgArray)
    {
        _imgArray = @[].mutableCopy;
    }
    return _imgArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
