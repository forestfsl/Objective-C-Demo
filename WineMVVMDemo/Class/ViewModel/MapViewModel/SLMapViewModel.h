//
//  SLMapViewModel.h
//  WineMVVMDemo
//
//  Created by songlin on 1/11/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "SLBaseViewModel.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface SLMapViewModel : SLBaseViewModel<BMKPoiSearchDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate>
///周边检索
@property(nonatomic,strong)RACCommand       *searchCommand;

///选择地址
@property(nonatomic,strong)RACCommand       *cellClick;

///代理
@property(nonatomic,strong)RACSubject       *addressSubject;

@end
