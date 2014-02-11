//
//  main.m
//  BMITime
//
//  Created by Patrick Reynolds on 2/9/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // Create a Person object
        Person *person = [[Person alloc] init];
        
        // Set Person object BMI attributes
        [person setWeightInKilos:96];
        [person setHeightInMeters:1.8];
        
        // Call the bodyMassIndex method
        float bmi = [person bodyMassIndex];
        NSLog(@"This person has a BMI of %f", bmi);
        
        
        // Create the BMIInfo struct
        struct BMIInfo info;
        
        // Set the BMIInfo struct attributes
        info.weightInKilos = 96;
        info.heightInMeters = 1.8;
        
        // Call the bodyMassIndex method that takes
        // a struct instead of using instance attributes
        float structBMIInfo = [person bodyMassIndex:info];
        NSLog(@"This structPerson has a BMI of %f", structBMIInfo);
    }
    return 0;
}

