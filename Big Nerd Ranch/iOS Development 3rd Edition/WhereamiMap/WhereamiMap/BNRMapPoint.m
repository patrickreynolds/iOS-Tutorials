//
//  BNRMapPoint.m
//  WhereamiMap
//
//  Created by Patrick Reynolds on 2/11/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "BNRMapPoint.h"

@interface BNRMapPoint ()

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;

@end

@implementation BNRMapPoint

@synthesize coordinate, title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    if (self) {
        coordinate = c;
        [self setTitle:t];
    }
    return self;
}

- (id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) title:@"Hometown"];
}

@end
