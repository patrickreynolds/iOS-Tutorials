//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Patrick Reynolds on 2/22/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;

- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
- (BOOL)saveChanges;
- (NSArray *)allAssetTypes;

@end
