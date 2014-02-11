//
//  Person.h
//  BMITime
//
//  Created by Patrick Reynolds on 2/9/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic) float heightInMeters;
@property (nonatomic) int weightInKilos;

struct BMIInfo {
    float heightInMeters;
    int weightInKilos;
};

- (float)bodyMassIndex;
- (float)bodyMassIndex :(struct BMIInfo)structPerson;

@end
