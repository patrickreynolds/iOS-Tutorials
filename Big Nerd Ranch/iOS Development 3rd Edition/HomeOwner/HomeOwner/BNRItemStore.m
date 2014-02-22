//
//  BNRItemStore.m
//  HomeOwner
//
//  Created by Patrick Reynolds on 2/12/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRImageStore.h"

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

- (id)init
{
    self = [super self];
    if (self) {
        NSString *path = [self itemArchivePath];
        self.allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If the array hadn't been saved previously, create a new empty one
        if (!self.allItems) self.allItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSMutableArray *)allItems
{
    if (!_allItems) _allItems = [[NSMutableArray alloc] init];
    return _allItems;
}

- (BNRItem *)createItem
{
    BNRItem *item = [[BNRItem alloc] init];
    [self.allItems addObject:item];
    return item;
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
    NSString *key = [item imageKey];
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    
    [self.allItems removeObjectIdenticalTo:item];
}

- (NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges
{
    // returns success or failure
    NSString *path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:self.allItems
                                       toFile:path];
}

@end
