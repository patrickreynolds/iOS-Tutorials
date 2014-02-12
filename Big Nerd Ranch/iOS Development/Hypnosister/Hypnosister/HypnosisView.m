//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Patrick Reynolds on 2/12/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)dirtyRect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    
    // Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width/2.0;
    center.y = bounds.origin.y + bounds.size.height/2.0;
    
    // The radius of the circle should be nearly as big as the view
    //float maxRadius = hypot(bounds.size.width, bounds.size.height) / 4.0;
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    // The thickness of the line should be 10 points wide
    CGContextSetLineWidth(ctx, 10);
    
    // The color of the line should be gray (red/green/blue = 0.6, alpha = 1.0);
    CGContextSetRGBStrokeColor(ctx, 0.4, 0.6, 0.9, 0.4);
    
    // Add a shape to the context - this does not draw the shape
    //CGContextAddArc(ctx, center.x, center.y, maxRadius, 0.0, M_PI * 2.0, YES);
    
    // Perform a drawing instruction; draw current shape with current state
    //CGContextStrokePath(ctx);
    
    // Draw concentric circles from the outside in
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        // Add path to context
        CGContextAddArc(ctx, center.x, center.y, currentRadius, 0.0, M_PI * 2.0, YES);
        
        // Perform drawing instruction; removes path
        CGContextStrokePath(ctx);
    }
    
    // Create a string
    NSString *text = @"You are getting sleepy.";
    
    // Get a font to draw it in
    UIFont *font = [UIFont boldSystemFontOfSize:28];
    
    CGRect textRect;
    
    textRect.origin.x = center.x;
    textRect.origin.y = center.y;
    
    // Set the fill color of the current context to black
    [[UIColor blackColor] setFill];
    
    // Draw the string
    [text drawInRect:textRect withAttributes:font];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
}
*/

@end
