//
//  SLQRCodeViewModel.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLQRCodeViewModel.h"

@implementation SLQRCodeViewModel


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
    @weakify(self);
    self.scanCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *input) {
        @strongify(self);
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:input]])
        {
            //            url
            UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:input]];
            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            NSString *message = [NSString stringWithFormat:@"是否要打开 ： %@",input];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描信息" message:message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:action1];
            [alert addAction:action0];
            [self.navImpl presentViewController:alert animated:YES complete:nil];
        }
        else
        {
            UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            NSString *message = input;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描信息" message:message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:action0];
            [self.navImpl presentViewController:alert animated:YES complete:nil];
            
        }
        return [RACSignal empty];
    }];
}

- (NSString *)handleURL:(NSString *)urlString
{
    NSString *str;
    if ([urlString rangeOfString:@"weixin"].location != NSNotFound)
    {
        str = [NSString stringWithFormat:@"weixin://%@",[urlString substringFromIndex:[urlString rangeOfString:@"weixin"].location]];
    }
    return str;
}
@end
