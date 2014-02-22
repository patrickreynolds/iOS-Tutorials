//
//  BNRItemStore.h
//  HomeOwner
//
//  Created by Patrick Reynolds on 2/12/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

@interface BNRItemStore : NSObject

+ (BNRItemStore *)sharedStore;

// return all items in the store
- (NSMutableArray *)allItems;

// Create an item in the store.
- (BNRItem *)createItem;

// Move an item from one passed position to another
- (void)moveItemAtIndex:(NSInteger)from :(NSInteger)to;

// Remove an item form a passed index.
- (void)removeItem:(BNRItem *)item;

- (NSString *)itemArchivePath;
- (BOOL)saveChanges;


@end
