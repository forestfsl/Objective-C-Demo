//
//  SLMapManager.m
//  WineMVVMDemo
//里面的一些代理方法要是想执行成功的话，那么demo中的dispaly name要改为好酒，Bundle Identifier要改为com.wang.WTKWineMVVM就可以了，因为这里是模仿别人demo的时候用到别人的key，自己没有去申请，是为了偷懒
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLMapManager.h"

@interface SLMapManager ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property(nonatomic,strong)BMKLocationService *locServices;

///正向地理编码
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;

@end

@implementation SLMapManager


+ (instancetype)manager
{
    static SLMapManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SLMapManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.errorSubject = [RACSubject subject];
        self.locationSubject = [RACSubject subject];
        self.locServices = [[BMKLocationService alloc]init];
        self.locServices.delegate = self;
        self.locServices.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.locServices.distanceFilter = 200;
        
    }
    return self;
}

- (void)startUserLocation;
{
    [self.locServices startUserLocationService];
}
- (void)stopUserLocation
{
    [self.locServices stopUserLocationService];
}


#pragma mark - BMKLocationDelegate  定位相关
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if (userLocation)
    {
        self.w_lng = userLocation.location.coordinate.longitude;
        self.w_lat = userLocation.location.coordinate.latitude;
        
        BMKReverseGeoCodeOption *reverseGeo = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeo.reverseGeoPoint = CLLocationCoordinate2DMake(self.w_lat, self.w_lng);
        [self.geoCodeSearch reverseGeoCode:reverseGeo];
        
    }
}
- (void)didFailToLocateUserWithError:(NSError *)error
{
    //    定位失败
    NSLog(@"定位失败error-%@",error);
    [self.errorSubject sendNext:error];
    [self.locServices stopUserLocationService];
}

#pragma mark - BMKGeoCodeSearchDelegate
//反地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        NSLog(@"address____result=%@",result.address);
        if(result.poiList.count != 0)
        {
            BMKPoiInfo *poiInfo = [result.poiList firstObject];
            NSString * nameStr = @"";
            NSString *cityStr = @"";
            NSString *subLocalityStr = @"";
            NSString *administrativeAreaStr = @"";
            
            //具体地址
            nameStr = poiInfo.name;
            //县
            subLocalityStr = result.addressDetail.district;
            //城市
            cityStr = poiInfo.city;
            //省份
            administrativeAreaStr = result.addressDetail.province;
            
            CURRENT_USER.city = cityStr;
            
            NSDictionary *dic = @{@"address":@{@"admin":administrativeAreaStr,@"city":cityStr,@"county":subLocalityStr,@"detail":nameStr},
                                  @"lat":@(poiInfo.pt.latitude),
                                  @"lng":@(poiInfo.pt.longitude)};
            CURRENT_USER.currentAddress = dic;
            [self.locationSubject sendNext:dic];
        }
        [self stopUserLocation];
    }
}

- (BMKGeoCodeSearch *)geoCodeSearch
{
    if (!_geoCodeSearch)
    {
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
    }
    return _geoCodeSearch;
}
- (void)dealloc
{
    _geoCodeSearch.delegate = nil;
    _locServices.delegate  = nil;
}
@end
