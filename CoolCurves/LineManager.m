//
//  LineManager.m
//  CoolCurves
//
//  Created by Stevie Hetelekides on 8/29/14.
//  Copyright (c) 2014 Expetelek. All rights reserved.
//

#import "LineManager.h"

@interface LineManager ()

@property (readwrite, assign) CGPoint finalPoint;

@end

@implementation LineManager
- (instancetype)initWithLine:(Line *)line percent:(CGFloat)percent
{
    self = [super init];
    
    if (self)
    {
        self.line = line;
        self.percent = percent;
    }
    
    return self;
}

- (void)setPercent:(CGFloat)percent
{
    // update the lines and final point
    [self updateLine:self.line percent:percent];
    self.finalPoint = [self.line pointAtPercent:percent];
    
    _percent = percent;
}

- (void)updateLine:(Line *)line percent:(CGFloat)percentage
{
    if (line.parent1 && line.parent2)
    {
        [self updateLine:line.parent1 percent:percentage];
        [self updateLine:line.parent2 percent:percentage];
        
        [line updatePoints:percentage];
    }
}
@end
