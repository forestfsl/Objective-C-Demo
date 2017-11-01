//
//  SLStarView.h
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseView.h"

typedef NS_ENUM(NSInteger,SLStarType){
    //整数
    SLStarTypeInteger = 0,
    //允许浮点(半颗星)
    
} ;

@interface SLStarView : SLBaseView

//block
@property (nonatomic, copy) void (^starBlock)(NSString *value);

///星级 0-5(默认5)
@property(nonatomic,assign)CGFloat star;

///是否允许触摸改变星级   默认YES
@property(nonatomic,assign)BOOL isTouch;

///类型（整形或者浮点型）
//@property(nonatomic,assign)SLStarType      starType;

/**
 *  构建方法
 *  @param starSize 星星大小（默认为平分，间距是大小的一半）,默认填CGSizeZero
 *  @param style    类型（WTKStarTypeInteger-不允许半颗星）SLStarTypeInteger下，star最低为1颗星
 */
- (instancetype)initWithFrame:(CGRect)frame
                     starSize:(CGSize)starSize
                    withStyle:(SLStarType)style;
@end
