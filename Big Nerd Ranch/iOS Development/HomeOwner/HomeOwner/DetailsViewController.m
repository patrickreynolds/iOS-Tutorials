//
//  DetialsViewController.m
//  HomeOwner
//
//  Created by Patrick Reynolds on 2/17/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"Detials view was loaded");
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Setting title
    self.title = self.item.itemName;
    
    // Namefield texts
    self.nameField.text = self.item.itemName;
    self.serialNumberField.text = self.item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
    
    // Create a NSDateFormatter that will turn a date into a simle date string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    // Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
}

@end
