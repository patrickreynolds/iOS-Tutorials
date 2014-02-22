//
//  QuizViewController.h
//  Quiz
//
//  Created by Patrick Reynolds on 2/10/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *questions;
@property (strong, nonatomic) NSMutableArray *answers;

- (IBAction)showQuestion:(UIButton *)sender;
- (IBAction)showAnswer:(UIButton *)sender;

@end
