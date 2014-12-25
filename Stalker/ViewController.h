//
//  ViewController.h
//  Stalker
//
//  Created by Keisuke Yamaguchi on 2014/12/25.
//  Copyright (c) 2014年 Keisuke Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

- (void)startStandardUpdates;

@end

