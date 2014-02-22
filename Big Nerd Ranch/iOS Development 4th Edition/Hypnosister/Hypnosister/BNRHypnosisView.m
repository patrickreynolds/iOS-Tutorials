//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Patrick Reynolds on 2/21/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
 - (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    // Figure out the cetner of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // The circle will be the largest that will fit in the view
    //float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    // The circle will be the largest that will fit in the view
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    /*
    [path addArcWithCenter:center
                    radius:radius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    */
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    path.lineWidth = 10.0;
    [[UIColor lightGrayColor] setStroke];
    
    [path stroke];
    
    UIImage *logoImage = [UIImage imageNamed:@"ios7_logo.png"];
    CGRect centerImage = CGRectMake(center.x - 50, center.y - 50, 100, 100);
    [logoImage drawInRect:centerImage];
}


@end
