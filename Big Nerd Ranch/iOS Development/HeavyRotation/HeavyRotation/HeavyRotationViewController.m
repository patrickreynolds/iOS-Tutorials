//
//  HeavyRotationViewController.m
//  HeavyRotation
//
//  Created by Patrick Reynolds on 2/12/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "HeavyRotationViewController.h"

@interface HeavyRotationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orientationAlert;

@end

@implementation HeavyRotationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIDevice *device = [UIDevice currentDevice];
    [device beginGeneratingDeviceOrientationNotifications];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(orientationChanged:)
                               name:UIDeviceOrientationDidChangeNotification
                             object:device];
}

- (void)orientationChanged:(NSNotification *)note
{
    // Log the constant that represents the current orientation
    NSLog(@"orientationChanged: %d", [[note object] orientation]);
    
    int orientationState = [[note object] orientation];
    
    switch (orientationState) {
        case 1:
            self.orientationAlert.text = @"Up!";
            break;
        case 2:
            self.orientationAlert.text = @"Upside down!";
            break;
        case 3:
            self.orientationAlert.text = @"Left!";
            break;
        case 4:
            self.orientationAlert.text = @"Right!";
            break;
        case 5:
            self.orientationAlert.text = @"Face up!";
            break;
        case 6:
            self.orientationAlert.text = @"Face down!";
            break;
        default:
            self.orientationAlert.text = @"Unknown state!";
            break;
    }
}

@end
