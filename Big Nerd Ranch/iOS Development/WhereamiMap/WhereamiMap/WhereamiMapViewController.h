//
//  WhereamiMapViewController.h
//  WhereamiMap
//
//  Created by Patrick Reynolds on 2/11/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereamiMapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>

- (void)findLocation;
- (void)foundLocation:(CLLocation *)location;

@end
