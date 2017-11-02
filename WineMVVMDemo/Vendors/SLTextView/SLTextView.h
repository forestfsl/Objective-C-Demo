//
//  SLTextView.h
//  WineMVVMDemo
//
//  Created by songlin on 2/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;

//构建方法
+ (instancetype)textView;

@end
