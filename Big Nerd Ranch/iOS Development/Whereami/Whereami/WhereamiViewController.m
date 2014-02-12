//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Patrick Reynolds on 2/11/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "WhereamiViewController.h"

@interface WhereamiViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextView *locationInfoUpdates;

@property (strong, nonatomic) NSMutableArray *locationUpdates;
@property (strong, nonatomic) NSString *allUpdates;
@property (nonatomic) int updatesRecieved;

@end

@implementation WhereamiViewController

// Lazy Instantiation
- (CLLocationManager *)locationManager
{
    if (!_locationManager) _locationManager = [[CLLocationManager alloc] init];
    return _locationManager;
}

// Lazy Instantiation
- (NSMutableArray *)locationUpdates
{
    if (!_locationUpdates) _locationUpdates = [[NSMutableArray alloc] init];
    return _locationUpdates;
}

// Lazy Instantiation
- (NSString *)allUpdates
{
    if (!_allUpdates) _allUpdates = [[NSString alloc] init];
    return _allUpdates;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
}

// Location manager method to retreive asynchronous updates
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
    [self.locationUpdates addObject:[locations lastObject]];
    [self updateLocationInfo];
}

// Errors received if there is an error in the location response.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

// Starting location updates.
- (IBAction)startUpdatingLocation:(UIButton *)sender
{
    [self.locationManager startUpdatingLocation];
}

// Stopping location updates.
- (IBAction)stopUpdatingLocation:(UIButton *)sender
{
    [self.locationManager stopUpdatingLocation];
}

// Clearing logged location data.
- (IBAction)clearLocationUpdateData:(UIButton *)sender
{
    // Setting all location based attributes back to nil or 0.
    self.allUpdates = nil;
    self.locationUpdates = nil;
    self.updatesRecieved = 0;
    [self updateLocationInfo];
}

// Updater method to set location logs in the UI.
- (void)updateLocationInfo
{
    for (id update in self.locationUpdates) {
        self.updatesRecieved++;
        
        //NSString *newUpdate = [update description];
        //newUpdate = [newUpdate stringByAppendingString:@"\n\n"];
        //newUpdate = [[NSString stringWithFormat:@"Update #%d\n", self.updatesRecieved] stringByAppendingString:newUpdate];
        
        // Nested ne liner for the code above
        NSString *newUpdate = [[NSString stringWithFormat:@"Update #%d\n", self.updatesRecieved] stringByAppendingString:[[update description] stringByAppendingString:@"\n\n"]];
        
        self.allUpdates = [self.allUpdates stringByAppendingString:newUpdate];
    }
    self.locationInfoUpdates.text = self.allUpdates;
}

- (BOOL)shouldAutorotate
{
    return false;
}


@end
