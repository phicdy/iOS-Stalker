//
//  MyAnnotation.m
//  Stalker
//
//  Created by Keisuke Yamaguchi on 2014/12/25.
//  Copyright (c) 2014年 Keisuke Yamaguchi. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    return self;
}

@end
