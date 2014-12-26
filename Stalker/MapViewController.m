//
//  MapViewController.m
//  Stalker
//
//  Created by Keisuke Yamaguchi on 2014/12/25.
//  Copyright (c) 2014年 Keisuke Yamaguchi. All rights reserved.
//

#import "MapViewController.h"
#import "MyAnnotation.h"

@interface MapViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property NSArray *shopList;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    _mapView.delegate = self;
    
    _mapView.frame = self.view.bounds;
    _mapView.mapType = MKMapTypeStandard;
//    _mapView.showsUserLocation = YES;
     [_mapView.userLocation addObserver:self
                            forKeyPath:@"location"
                               options:0
                               context:NULL];
    
//    MKAnnotationView* aView = [[MKAnnotationView alloc] initWithAnnotation:annotation
//                                                           reuseIdentifier:@"MyCustomAnnotation"];
////    aView.image = [UIImage imageNamed:@"myimage.png"];
//    aView.centerOffset = CGPointMake(10, -20);
    
    _shopList = @[
                      @{@"shopNo":@"001", @"shopName":@"イベントガーデン",  	@"ganre": @"バル",        @"lat":@"34.671140", @"lon":@"135.493251"}
                      ,@{@"shopNo":@"002", @"shopName":@"卓球バー",      		@"ganre": @"バー",        @"lat":@"34.672503", @"lon":@"135.494903"}
                      ];
    
    CLLocationCoordinate2D location;
    location.latitude = 34.67174;         // 経度
    location.longitude = 135.496201;  // 緯度
    [_mapView setCenterCoordinate:location animated:NO];
    
    // 縮尺を指定
    MKCoordinateRegion region = _mapView.region;
    region.center = location;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    [self.mapView setRegion:region animated:NO];
    
    for (NSDictionary* dic in self.shopList) {
        // CustomAnnotationはMKAnnotationを継承したサブクラス。
        // MKAnnotationだけでも使えるが制約が多いので自由なサブクラスをつくることをおすすめ。
        CLLocationCoordinate2D coodinate = CLLocationCoordinate2DMake([dic[@"lat"] floatValue], [dic[@"lon"] floatValue]); // 緯度経度
        MyAnnotation *pin = [[MyAnnotation alloc] initWithLocation:coodinate];
        pin.title = dic[@"shopName"];//タイトル
        pin.subtitle = dic[@"ganre"];//サブタイトル
        
        [_mapView addAnnotation:pin];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    _mapView.centerCoordinate = _mapView.userLocation.location.coordinate;
    
    // 表示倍率の設定
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(_mapView.userLocation.coordinate, span);
    [_mapView setRegion:region animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id )annotation
{
    static NSString* Identifier = @"PinAnnotationIdentifier";
    MKPinAnnotationView* pinView =
    (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:Identifier];
    
    // 現在地表示なら nil を返す
    if (annotation == mapView.userLocation) {
        return nil;
    }
    
    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                  reuseIdentifier:Identifier];
        pinView.animatesDrop = YES;     // 落下アニメーションありなし
        pinView.canShowCallout = YES;  // 吹き出し表示するか
        pinView.draggable = YES;           // ドラッグできるか
        pinView.rightCalloutAccessoryView =
        [UIButton buttonWithType:UIButtonTypeDetailDisclosure]; // 右側にアクセサリ
    } else {
        pinView.annotation = annotation;
    }
    return pinView;
}

- (void) mapView:(MKMapView*)_mapView annotationView:(MKAnnotationView*)annotationView calloutAccessoryControlTapped:(UIControl*)control {
    NSLog(@"%s アクセサリタップ",__func__);
    
    MyAnnotation* pin = (MyAnnotation*)annotationView.annotation;
    NSLog(@"title:%@",pin.title);
    
    // タップしたときの処理
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    // Pause
}

@end
