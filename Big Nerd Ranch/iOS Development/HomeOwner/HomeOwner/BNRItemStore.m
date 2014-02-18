//
//  BNRItemStore.m
//  HomeOwner
//
//  Created by Patrick Reynolds on 2/12/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "BNRItemStore.h"

@interface BNRItemStore()

@property (strong, nonatomic) NSMutableArray *allItems;

@end

@implementation BNRItemStore


+ (BNRItemStore *)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore) sharedStore = [[super allocWithZone:nil] init];
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

- (NSMutableArray *)allItems
{
    if (!_allItems) _allItems = [[NSMutableArray alloc] init];
    return _allItems;
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self.allItems addObject:item];
    return item;
}

- (void)addBlankItem
{
    BNRItem *item = [[BNRItem alloc] init];
    item.itemName = @"No more items";
    item.serialNumber = @"";
    item.valueInDollars = 0;
    item.dateCreated = [NSDate date];
    [self.allItems addObject:item];
}

- (void)moveItemAtIndex:(NSInteger)from :(NSInteger)to
{
    if (from == to) {
        return;
    }
    
    // Get pointer to object being moved so we can re-insert it
    BNRItem *movedItem = [self.allItems objectAtIndex:from];
    
    // Remove movedItem form array
    [self.allItems removeObjectAtIndex:from];
    
    // Insert movedItem in array atnew location
    [self.allItems insertObject:movedItem atIndex:to];
}

- (void)removeItem:(BNRItem *)item
{
    [self.allItems removeObjectIdenticalTo:item];
}

@end
