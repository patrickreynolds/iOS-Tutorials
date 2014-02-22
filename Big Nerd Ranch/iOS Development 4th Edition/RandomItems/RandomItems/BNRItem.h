//
//  BNRItem.h
//  RandomItems
//
//  Created by Patrick Reynolds on 2/21/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
// Question: What is the difference between curly braces and @properties?
/*
{
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate *_dateCreated;
}
*/

@property (copy, nonatomic) NSString *itemName;
@property (copy ,nonatomic) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (strong, nonatomic, readonly) NSDate *dateCreated;

@property (strong, nonatomic) BNRItem *containedItem;
@property (weak, nonatomic) BNRItem *container;

+ (instancetype)randomItem;

// Designated initializer for BNRItem
- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;

// Silver Challange
- (instancetype)initWithItemName:(NSString *)name
                 andSerialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;


- (NSString *)description;

@end
