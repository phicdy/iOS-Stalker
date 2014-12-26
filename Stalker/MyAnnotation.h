//
//  MyAnnotation.h
//  Stalker
//
//  Created by Keisuke Yamaguchi on 2014/12/25.
//  Copyright (c) 2014年 Keisuke Yamaguchi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end
