//
//  SLTextView.m
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLTextView.h"

@interface SLTextView ()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *sl_label;
@end

//#define ZOOM_SCALL kWidth/375.0

@implementation SLTextView

+(instancetype)textView {
    return [[self alloc]init];
}

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
        self.delegate = self;
    }
    return self;
}

- (void)initView {
    self.sl_label = [[UILabel alloc]initWithFrame:CGRectMake(10 * ZOOM_SCALL, 0 * ZOOM_SCALL, 300 * ZOOM_SCALL, 30 * ZOOM_SCALL)];
    self.sl_label.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    self.sl_label.font = self.font;
    self.sl_label.text = @"placeholder";
    [self addSubview:self.sl_label];
}

-(void)setText:(NSString *)text {
    [super setText:text];
    if (self.text.length == 0) {
        self.sl_label.hidden = NO;
    }else {
        self.sl_label.hidden = YES;
    }
}

-(void)setFont:(UIFont *)font {
    [super setFont:font];
    self.sl_label.font = font;
    self.sl_label.frame = CGRectMake(10 * ZOOM_SCALL, 0 * ZOOM_SCALL, 300 * ZOOM_SCALL, (font.pointSize + 17) * ZOOM_SCALL);
}

-(void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.sl_label.text = placeholder;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length == 0 && textView.text.length == 1)
    {
        self.sl_label.hidden = NO;
        return YES;
    }
    if (text.length == 0 && textView.text.length == 0)
    {
        self.sl_label.hidden = NO;
        return YES;
    }
    self.sl_label.hidden = YES;
    return YES;
}

@end
