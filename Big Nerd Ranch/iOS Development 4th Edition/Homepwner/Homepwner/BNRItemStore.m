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

@end
