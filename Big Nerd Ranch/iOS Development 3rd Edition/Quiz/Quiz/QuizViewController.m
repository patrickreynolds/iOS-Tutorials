//
//  QuizViewController.m
//  Quiz
//
//  Created by Patrick Reynolds on 2/10/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@property (weak, nonatomic) IBOutlet UILabel *questionField;
@property (weak, nonatomic) IBOutlet UILabel *answerField;

@property (nonatomic) int currentQuestionIndex;
@end

@implementation QuizViewController

// Initializing questions array using lazy instantiation
- (NSMutableArray *)questions
{
    if (!_questions) _questions = [[NSMutableArray alloc]init];
    return _questions;
}

// Initializing answers array using lazy instantiation
- (NSMutableArray *)answers
{
    if (!_answers) _answers = [[NSMutableArray alloc] init];
    return _answers;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadQuestions];
    [self loadAnswers];
    self.currentQuestionIndex = 0;
    [self setQuestion];
    [self setAnswer:false];
}

// Initializing questions in questions array
- (void)loadQuestions
{
    [self.questions addObject:@"What is 7 + 7?"];
    [self.questions addObject:@"What is the capital of Vermont?"];
    [self.questions addObject:@"From what is congnac made?"];
}

// Initializing questions in questions array
- (void)loadAnswers
{
    [self.answers addObject:@"14"];
    [self.answers addObject:@"Montpelier"];
    [self.answers addObject:@"Grapes"];
}

- (IBAction)showQuestion:(UIButton *)sender
{
    self.currentQuestionIndex++;
    
    if (self.currentQuestionIndex == [self.questions count])
    {
        self.currentQuestionIndex = 0;
    }
    
    [self setQuestion];
    [self setAnswer:false];
}

- (IBAction)showAnswer:(UIButton *)sender
{
    [self setAnswer:true];
}

- (void)setQuestion
{
    self.questionField.text = [self.questions objectAtIndex:self.currentQuestionIndex];
}

- (void)setAnswer :(BOOL)withAnswer
{
    if (withAnswer) {
        self.answerField.text = [self.answers objectAtIndex:self.currentQuestionIndex];
    } else {
        self.answerField.text = @"???";
    }
}


@end
