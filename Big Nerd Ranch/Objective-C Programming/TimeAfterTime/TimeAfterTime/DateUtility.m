//
//  DateUtility.m
//  TimeAfterTime
//
//  Created by Patrick Reynolds on 2/9/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "DateUtility.h"

@implementation DateUtility

- (int)hoursSinceDate :(NSDate *)date
{
    #define NUBMER_OF_SECONDS_IN_ONE_HOUR 3600
    
    NSDate *currentTime = [NSDate date];
    double secondsSinceDate = [currentTime timeIntervalSinceDate:date];
    return (int)secondsSinceDate / NUBMER_OF_SECONDS_IN_ONE_HOUR;
}

@end
