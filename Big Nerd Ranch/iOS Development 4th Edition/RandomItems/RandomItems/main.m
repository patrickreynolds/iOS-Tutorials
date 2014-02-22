//
//  main.m
//  RandomItems
//
//  Created by Patrick Reynolds on 2/21/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // Creating a mutable array object, and storing its address in tiems variable
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        /* // Replacing with 10 random items
        [items addObject:@"One"];
        [items addObject:@"Two"];
        [items addObject:@"Three"];
        
        // Send another message, insertObject:atIndex:, to that same array object
        [items insertObject:@"Zero" atIndex:0];
        
        for(int i = 0; i < items.count; i++) {
            NSLog(@"Item: %@", [items objectAtIndex:i]);
        }
        
        for(NSString *item in items) {
            NSLog(@"Item: %@", item);
        }
        
        // Designated initializer
        BNRItem *item = [[BNRItem alloc] initWithItemName:@"Red Sofa" valueInDollars:100 serialNumber:@"123456"];
        NSLog(@"%@", item);
        
        BNRItem *itemWithName = [[BNRItem alloc] initWithItemName:@"Blue Sofa"];
        NSLog(@"%@", itemWithName);
        
        BNRItem *itemWithNoName = [[BNRItem alloc] init];
        NSLog(@"%@", itemWithNoName);
         */
        
        // Initializing 10 random items
        for (int i = 0; i < 10; i++) {
            BNRItem *item = [BNRItem randomItem];
            [items addObject:item];
        }
        
        // Printing 10 random items
        for (BNRItem *item in items) {
            NSLog(@"%@", item);
        }
        
        // Destroy the mutable array object
        NSLog(@"Setting all items to nil.");
        items = nil;
        
    }
    return 0;
}

