//
//  QuickTempViewController.m
//  QuickTemp
//
//  Created by Patrick Reynolds on 2/10/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "QuickTempViewController.h"

@interface QuickTempViewController ()

@property (strong, nonatomic) IBOutlet UITextField *temperatureInput;
@property (strong, nonatomic) IBOutlet UILabel *temperatureResult;
@property (strong, nonatomic) IBOutlet UISegmentedControl *fromMetricSelection;
@property (strong, nonatomic) IBOutlet UISegmentedControl *toMetricSelection;

@end

@implementation QuickTempViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.temperatureInput.text = @"0";
    [self convertTemp];
}

- (IBAction)convertTemp {
    
    if([self.fromMetricSelection selectedSegmentIndex] == 1){
        double celsius = [self.temperatureInput.text doubleValue];
        double fahrenheit = (celsius * 1.8) + 32;
        
        NSString *resultString = [[NSString alloc] initWithFormat:@"Fahrenheit %0.00f", fahrenheit];
        self.temperatureResult.text = resultString;
        
        self.toMetricSelection.selectedSegmentIndex = 0;
    }else {
        double fahrenheit = [_temperatureInput.text doubleValue];
        double celsius = (fahrenheit - 32) / 1.8;
        
        NSString *resultString = [[NSString alloc]
                                  initWithFormat: @"Celsius %0.00f", celsius];
        self.temperatureResult.text = resultString;
        
        self.toMetricSelection.selectedSegmentIndex = 1;
    }
}

- (IBAction)getFromMetricSelection:(id)sender {
    [self convertTemp];
}

- (IBAction)getToMetricSelection:(id)sender {
    [self convertTemp];
}

- (IBAction)inputChanged:(id)sender {
    [self convertTemp];
}

- (IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.temperatureInput isFirstResponder] && [touch view] != self.temperatureInput) {
        [self.temperatureInput resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

@end
