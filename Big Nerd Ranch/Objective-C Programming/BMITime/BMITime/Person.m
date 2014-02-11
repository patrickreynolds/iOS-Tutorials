//
//  Person.m
//  BMITime
//
//  Created by Patrick Reynolds on 2/9/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "Person.h"

@implementation Person

- (float)bodyMassIndex
{
    return self.weightInKilos / (self.heightInMeters * self.heightInMeters);
}

- (float)bodyMassIndex :(struct BMIInfo)structPerson
{
    return structPerson.weightInKilos / (structPerson.heightInMeters * structPerson.heightInMeters);
}

@end
