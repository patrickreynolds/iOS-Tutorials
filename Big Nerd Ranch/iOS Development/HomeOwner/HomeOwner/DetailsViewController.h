//
//  DetialsViewController.h
//  HomeOwner
//
//  Created by Patrick Reynolds on 2/17/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRItem.h"

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) BNRItem *item;

@end
