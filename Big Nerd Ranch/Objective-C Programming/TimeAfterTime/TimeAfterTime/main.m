//
//  main.m
//  TimeAfterTime
//
//  Created by Patrick Reynolds on 2/9/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "DateUtility.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // Get and print current date
        NSDate *now = [NSDate date];
        NSLog(@"The new date lives at %@.\n", now);
        
        // Get and print seconds since 1970
        double secondsSince1970 = [now timeIntervalSince1970];
        NSLog(@"It has been %.2f seconds since the start of 1970.\n", secondsSince1970);
        
        // Get and print the date of 100000 seconds from now
        NSDate *tenThousandSecondsFromNow = [now dateByAddingTimeInterval:100000];
        NSLog(@"In 100,000 seconds it will be %@.\n", tenThousandSecondsFromNow);
        
        // Initialize and set birth date components
        NSDateComponents *myBirthDateComponents = [[NSDateComponents alloc] init];
        [myBirthDateComponents setYear:1991];
        [myBirthDateComponents setMonth:7];
        [myBirthDateComponents setDay:26];
        [myBirthDateComponents setHour:23];
        [myBirthDateComponents setMinute:36];
        
        // Make a NSDate by using NSCalendar and NSDate components
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *myDateOfBirth = [calendar dateFromComponents:myBirthDateComponents];
        
        // Using timeIntervalSinceDate to get epotch seconds since I was born
        double secondsSinceIWasBorn = [now timeIntervalSinceDate:myDateOfBirth];
        
        #define SECONDS_IN_A_YEAR 31536000
        #define SECONDS_IN_A_DAY 86400
        #define SECONDS_IN_A_HOUR 3600
        #define SECONDS_IN_A_MINUTE 60
        
        // Print how many seconds since I was born.
        NSLog(@"\n\nBig Nerd Ranch Objective-C Programming: Chapter 12 Exercise");
        NSLog(@"It has been %.2f years since I was born.", secondsSinceIWasBorn / SECONDS_IN_A_YEAR);
        NSLog(@"It as been %.2f days since I was born.\n", secondsSinceIWasBorn / SECONDS_IN_A_DAY);
        NSLog(@"It as been %.2f hours since I was born.\n", secondsSinceIWasBorn / SECONDS_IN_A_HOUR);
        NSLog(@"It as been %.2f minutes since I was born.\n", secondsSinceIWasBorn / SECONDS_IN_A_MINUTE);
        NSLog(@"It as been %.2f seconds since I was born.\n", secondsSinceIWasBorn);
        
    }
    return 0;
}

