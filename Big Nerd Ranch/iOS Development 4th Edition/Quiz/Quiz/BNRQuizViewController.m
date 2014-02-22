//
//  BNRQuizViewController.m
//  Quiz
//
//  Created by Patrick Reynolds on 2/21/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "BNRQuizViewController.h"

@interface BNRQuizViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@property (nonatomic) int currentQuestionIndex;

@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answers;

@end

@implementation BNRQuizViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.questions = @[@"From what is cognac made?",
                           @"What is 7 + 7",
                           @"What is the capital of Vermont?"];
        self.answers = @[@"Grapes",
                         @"14",
                         @"Montpelier"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)showQuestion:(UIButton *)sender
{
    self.currentQuestionIndex++;
    
    // Am I past the last question?
    if (self.currentQuestionIndex == [self.questions count]) {
        self.currentQuestionIndex = 0;
    }
    
    // Display the string in the question label
    self.questionLabel.text = self.questions[self.currentQuestionIndex];;
    
    // Reset the answer label
    self.answerLabel.text = @"???";
}

- (IBAction)showAnswer:(UIButton *)sender
{
    self.answerLabel.text = self.answers[self.currentQuestionIndex];
}


@end
