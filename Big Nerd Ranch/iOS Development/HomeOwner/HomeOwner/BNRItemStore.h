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
- (NSMutableArray *)allItems;
- (BNRItem *)createItem;

@end
