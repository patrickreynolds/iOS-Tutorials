//
//  main.m
//  LocalHost
//
//  Created by Patrick Reynolds on 2/11/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Host.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSHost *host = [NSHost currentHost];
    
        NSLog(@"Host Name: %@", [Host getNameOfHost:host]);
        NSLog(@"Localized Host Name: %@", [Host getLocalizedNameOfHost:host]);
        NSLog(@"Host Address: %@", [Host getAddressOfHost:host]);
        
    }
    return 0;
}

