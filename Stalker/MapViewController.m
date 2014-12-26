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
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
     [_mapView.userLocation addObserver:self
                            forKeyPath:@"location"
                               options:0
                               context:NULL];
    
    
    
    NSDictionary *lastLocation = [locationList lastObject];
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([lastLocation[@"lat"] floatValue], [lastLocation[@"lon"] floatValue]);
    [_mapView setCenterCoordinate:location animated:NO];
    
    // 縮尺を指定
    MKCoordinateRegion region = _mapView.region;
    region.center = location;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    [self.mapView setRegion:region animated:NO];
    
    
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
    
    if (annotation == mapView.userLocation) {
        return nil;
    }
    
    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                  reuseIdentifier:Identifier];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        pinView.draggable = YES;
        pinView.rightCalloutAccessoryView =
        [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    } else {
        pinView.annotation = annotation;
    }
    return pinView;
}

- (void) mapView:(MKMapView*)_mapView annotationView:(MKAnnotationView*)annotationView calloutAccessoryControlTapped:(UIControl*)control {
    NSLog(@"%s アクセサリタップ",__func__);
    
    MyAnnotation* pin = (MyAnnotation*)annotationView.annotation;
    NSLog(@"title:%@",pin.title);
    
    
}

@end
