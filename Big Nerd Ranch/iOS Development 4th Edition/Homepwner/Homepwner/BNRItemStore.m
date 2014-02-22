//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Patrick Reynolds on 2/22/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItmes;

@end

@implementation BNRItemStore

- (NSMutableArray *)privateItmes
{
    if (!_privateItmes) _privateItmes = [[NSMutableArray alloc] init];
    return _privateItmes;
}

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

// If a programmer calls [[BNRItemStore alloc] init], let them know
// the rror of their ways
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    
    return self;
}

- (NSArray *)allItems
{
    return self.privateItmes;
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    
    [self.privateItmes addObject:item];
    
    return item;
}

- (void)removeItem:(BNRItem *)item
{
    [self.privateItmes removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    
    // Get pointer to object being moved so you can re-insert it
    BNRItem *item = self.privateItmes[fromIndex];
    
    // Remove item from array
    [self.privateItmes removeObjectAtIndex:fromIndex];
    
    // Insert item in array at new location
    [self.privateItmes insertObject:item atIndex:toIndex];
}

@end
