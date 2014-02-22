//
//  BNRItem.h
//  HomeOwner
//
//  Created by Patrick Reynolds on 2/12/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject <NSCoding>

@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (strong, nonatomic) NSDate *dateCreated;
@property (strong, nonatomic) NSString *imageKey;

@property (strong, nonatomic) UIImage *thumbnail;
@property (strong, nonatomic) NSData *thumbnailData;

@property (strong, nonatomic) BNRItem *containedItem;
@property (strong, nonatomic) BNRItem *container;

+ (id)randomItem;

- (void)setThumbnailDataFromImage:(UIImage *)image;

- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

- (id)initWithItemName:(NSString *)name
        valueInDollars:(int)value
          serialNumber:(NSString *)sNumber;

@end
