//
//  BNRItem.h
//  RandomItems
//
//  Created by Patrick Reynolds on 2/21/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject <NSCoding>

@property (copy, nonatomic) NSString *itemName;
@property (copy ,nonatomic) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (strong, nonatomic, readonly) NSDate *dateCreated;
@property (nonatomic, copy) NSString *itemKey;

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
