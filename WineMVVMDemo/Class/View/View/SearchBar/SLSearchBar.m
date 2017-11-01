//
//  SLSearchBar.m
//  WineMVVMDemo
//
//  Created by songlin on 29/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLSearchBar.h"

@interface SLSearchBar ()

@property (nonatomic, strong) UIView *view;

@end

@implementation SLSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configInterface];
    }
    return self;
}

-(void)configSelf {
    self.backgroundColor = [UIColor clearColor];
}

- (void)configSubView {
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kWidth - 100, 30)];
    _searchBar.placeholder = @"search";
    _searchBar.tintColor  = SLCOLOR(255, 255, 255, 0);
    _searchBar.backgroundColor      = [UIColor clearColor];
    [_searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0] size:CGSizeMake(kWidth - 160, 30)] forState:UIControlStateNormal];
    for (UIView *subView in _searchBar.subviews) {
        for (UIView *grandSonView in subView.subviews) {
            if ([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                grandSonView.backgroundColor = SLCOLOR(255, 255, 255, 0);
                grandSonView.alpha = 0;
            }else if([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarTextField")] ){
                grandSonView.backgroundColor = SLCOLOR(245, 245, 245, 0);
                self.view = grandSonView;
                NSLog(@"Keep textfiedld bkg color");
            }else{
                grandSonView.backgroundColor = SLCOLOR(255, 255, 255, 0);
            }
        }
    }
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self addSubview:_searchBar];
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    _searchBar.layer.cornerRadius = 5;
    _searchBar.layer.masksToBounds = YES;
}


-(void)setSl_bgColor:(UIColor *)sl_bgColor {
    _sl_bgColor = sl_bgColor;
    self.view.backgroundColor = sl_bgColor;
}



@end
