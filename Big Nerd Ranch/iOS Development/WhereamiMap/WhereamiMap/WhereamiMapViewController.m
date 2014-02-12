//
//  WhereamiMapViewController.m
//  WhereamiMap
//
//  Created by Patrick Reynolds on 2/11/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "WhereamiMapViewController.h"
#import "BNRMapPoint.h"

@interface WhereamiMapViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet MKMapView *worldView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITextView *locationTitleField;


@end

@implementation WhereamiMapViewController

- (CLLocationManager *)locaitonManager
{
    if (!_locationManager) _locationManager = [[CLLocationManager alloc] init];
    return _locationManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [self.worldView setShowsUserLocation:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
    NSTimeInterval timeInterval = [[locations lastObject] timeIntervalSinceNow];
    
    if (timeInterval < -180) {
        // This is cached data, you don't want it, keep looking.
        return;
    }
    
    [self foundLocation:[locations lastObject]];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location Manager failed with error: %@", error);
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"Updated user location: %@", userLocation.title);
    // Add map zoom
    CLLocationCoordinate2D location = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 10000, 10000);
    [self.worldView setRegion:region animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self findLocation];
    [self.locationTitleField resignFirstResponder];
    
    return YES;
}

- (void)findLocation
{
    [self.locationManager startUpdatingLocation];
    [self.activityIndicator startAnimating];
    [self.locationTitleField setHidden:YES];
}

- (void)foundLocation:(CLLocation *)location
{
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    // Create an instance of BNRMapPoint with the current data
    BNRMapPoint *mapPoint = [[BNRMapPoint alloc] initWithCoordinate:coordinate title:[self.locationTitleField text]];
    NSLog(@"Made mapPoint!");
    // Add annotation to the map
    [self.worldView addAnnotation:mapPoint];
    
    // Zoom to the region
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 5000, 5000);
    [self.worldView setRegion:region];
    
    // Reseting the UI to natural state
    [self resetUI];
}

- (void)resetUI
{
    // Reset the UI
    [self.locationTitleField setText:@""];
    [self.activityIndicator stopAnimating];
    [self.locationTitleField setHidden:NO];
    [self.locationManager stopUpdatingLocation];
}

@end
