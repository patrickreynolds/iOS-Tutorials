//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by Patrick Reynolds on 2/22/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController <UIViewControllerRestoration>

@property (strong, nonatomic) BNRItem *item;
@property (copy, nonatomic) void (^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew;

@end
