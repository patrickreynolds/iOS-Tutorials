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

/*
- (id)init
{
    self = [super init];
    if (self) {
        if (!_allItems) _allItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}
 */

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
    //return @[];
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self.allItems addObject:item];
    return item;
}

@end
