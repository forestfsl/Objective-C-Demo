//
//  SLRequestManager.m
//  WineMVVMDemo
//
//  Created by songlin on 30/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLRequestManager.h"

@implementation SLRequestManager


+ (RACSignal *)postArrayDataWithURL:(NSString *)urlString parameter:(NSDictionary *)parameter {
    CGFloat time = arc4random() % 5 / 10.0;
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:urlString ofType:nil]];
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:array];
        [subscriber sendCompleted];
        return nil;
    }]delay:time];
}

+ (RACSignal *)postDicDataWithURL:(NSString *)urlString parameter:(NSDictionary *)parameter {
    CGFloat time = arc4random()%15 / 10.0;
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:urlString ofType:nil]];
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:dic];
        [subscriber sendCompleted];
        return nil;
    }] delay:time];
}


+ (RACSignal *)getWithURL:(NSString *)urlString parameter:(NSDictionary *)parameter {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    RACSubject *sub = [RACSubject subject];
    [manager GET:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [sub sendNext:@{@"code":@100,@"data":responseObject}];
        [sub sendCompleted];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [sub sendNext:@{@"code":@-400,@"data":@"请求失败"}];
        [sub sendCompleted];
    }];
    return sub;
}

+ (RACSignal *)postWithURL:(NSString *)urlString parameter:(NSDictionary *)parameter {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    RACSubject *sub =[ RACSubject subject];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager POST:urlString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [sub sendNext:responseObject];
        [sub sendCompleted];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [sub sendNext:@{@"code":@-400}];
        [sub sendCompleted];
    }];
    [manager GET:urlString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response---%@",responseObject);
        id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    return sub;
}
@end
