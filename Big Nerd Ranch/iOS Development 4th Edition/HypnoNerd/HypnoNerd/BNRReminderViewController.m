//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by Patrick Reynolds on 2/22/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "BNRReminderViewController.h"

@interface BNRReminderViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Reminder";
        
        // Create a UIImage from a file
        // This will use Hypno@2x.png on retina display devices
        UIImage *image = [UIImage imageNamed:@"Time.png"];
        
        // Put that image on the tab bar item
        self.tabBarItem.image = image;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"BNRReminderViewController will appear.");
    
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"BNRReminderViewController loaded its view.");
}

- (IBAction)addReminder:(UIButton *)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@.", date);
    
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"Hypnotize me!";
    note.fireDate = date;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
