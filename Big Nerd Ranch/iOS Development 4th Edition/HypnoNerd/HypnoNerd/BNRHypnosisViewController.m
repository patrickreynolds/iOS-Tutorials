//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Patrick Reynolds on 2/22/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>
@property (weak, nonatomic) UITextField *textField;
@end

@implementation BNRHypnosisViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        
        // Create a UIImage from a file
        // This will use Hypno@2x.png on retina display devices
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        
        // Put that image on the tab bar item
        self.tabBarItem.image = image;
    }
    return self;
}

- (void)loadView
{
    // Create a view
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];
    
    // Add a UITextView
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    // Setting the border style on a text field will allow us to see if more easily
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    textField.delegate = self;
    [backgroundView addSubview:textField];
    
    [self interpolateObject:textField withSway:5];
    
    self.textField = textField;
    self.view = backgroundView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"BNRHypnosisViewController loaded its view.");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"BNRHypnosisViewController will appear.");
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
         usingSpringWithDamping:0.25
          initialSpringVelocity:0.0
                        options:0
                     animations:^{
                         CGRect frame = CGRectMake(40, 70, 240, 30);
                         self.textField.frame = frame;
                     } completion:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];
    NSLog(@"Text Field Text: %@", textField.text);
    
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 10; i++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        
        // Configure the label's color and test
        messageLabel.textColor = [UIColor blueColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.text = message;
        
        // This method resizes the label, which will be relative
        // to the text that it is displaying
        [messageLabel sizeToFit];
        
        // Get a random x value that fits within the hypnosis view's width
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        
        // Get a random y value that fits within the hypnosis view's height
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        
        // Update the label's frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        // Add annimations
        messageLabel.alpha = 0.0;
        
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
            // Add message label to the hierarchy
            [self.view addSubview:messageLabel];
            
            messageLabel.alpha = 1.0;
        } completion:NULL];
        
        [UIView animateKeyframesWithDuration:1.0
                                       delay:0.0
                                     options:0 animations:^{
                                         [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.8 animations:^{
                                             messageLabel.center = self.view.center;
                                         }];
                                         
                                         [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
                                             int x = arc4random() % width;
                                             int y = arc4random() % height;
                                             messageLabel.center = CGPointMake(x, y);
                                         }];
                                     } completion:^(BOOL finished) {
                                         NSLog(@"Animation finished");
                                     }];
        
        [self interpolateObject:messageLabel withSway:25];
    }
}

- (void)interpolateObject:(UIView *)view withSway:(NSInteger)sway
{
    UIInterpolatingMotionEffect *motionEffect;
    motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    motionEffect.minimumRelativeValue = @(-sway);
    motionEffect.maximumRelativeValue = @(sway);
    [view addMotionEffect:motionEffect];
    
    motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    motionEffect.minimumRelativeValue = @(-sway);
    motionEffect.maximumRelativeValue = @(sway);
    [view addMotionEffect:motionEffect];
}
@end
