//
//  Line.m
//  CoolCurves
//
//  Created by Stevie Hetelekides on 8/29/14.
//  Copyright (c) 2014 Expetelek. All rights reserved.
//

#import "Line.h"

@implementation Line
- (NSArray *)associatedLines
{
    // work up the tree and get all lines
    NSMutableArray *lines = [[NSMutableArray alloc] init];
    [self associatedLines:self currentLines:lines];
    return [lines copy];
}

- (void)associatedLines:(Line *)line currentLines:(NSMutableArray *)currentLines
{
    // add the current line
    [currentLines addObject:line];
    
    // if it has any parents, do the same
    if (line.parent1)
        [self associatedLines:line.parent1 currentLines:currentLines];
    if (line.parent2)
        [self associatedLines:line.parent2 currentLines:currentLines];
}

- (CGPoint)pointAtPercent:(CGFloat)percent
{
    // calculate the distances between the points
    CGFloat xDistance = self.endPoint.x - self.startPoint.x;
    CGFloat yDistance = self.endPoint.y - self.startPoint.y;
    
    // get the percents of those distances
    CGFloat x = (xDistance * percent);
    CGFloat y = (yDistance * percent);
    
    // append the calculated x and y values to the current position
    return CGPointMake(self.startPoint.x + x, self.startPoint.y + y);
}

- (void)updatePoints:(CGFloat)percent
{
    self.startPoint = [self.parent1 pointAtPercent:percent];
    self.endPoint = [self.parent2 pointAtPercent:percent];
}
@end
