//
//  SLFunctionViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 31/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLFunctionViewModel.h"

@implementation SLFunctionViewModel
- (instancetype)initWithService:(id<SLViewModelServices>)service params:(NSDictionary *)params
{
    self = [super initWithService:service params:params];
    if (self)
    {
        [self initViewModel];
    }
    return self;
}

- (void)initViewModel
{
    self.switchCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        UISwitch *sw = input;
        if (sw.tag == 0)
        {
            CURRENT_USER.isSound = sw.on;
        }
        else if (sw.tag == 1)
        {
            CURRENT_USER.isShake = sw.on;
        }
        else if (sw.tag == 2)
        {
            if (sw.on)
            {
                [SLTool registTouchIDWithCompleteBlock:^(NSString *str) {
                    if ([str isEqualToString:@"验证成功"])
                    {
                        sw.on = YES;
                        SHOW_SUCCESS(@"验证成功");
                    }
                    else
                    {
                        sw.on = NO;
                        SHOW_ERROE(str);
                        DISMISS_SVP(1.3);
                    }
                }];
            }
            else
            {
                [SLTool delegateTouchID];
            }
        }
        else
        {
            CURRENT_USER.isNight = sw.on;
            [SLTool startNightSche];
        }
        return [RACSignal empty];
    }];
}

@end
