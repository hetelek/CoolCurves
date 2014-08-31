//
//  DrawingView.m
//  CoolCurves
//
//  Created by Stevie Hetelekides on 8/29/14.
//  Copyright (c) 2014 Expetelek. All rights reserved.
//

#import "LineCanvas.h"

@interface LineCanvas ()

@property LineManager *manager;

@end

@implementation LineCanvas
- (void)setLine:(Line *)line
{
    _line = line;
    
    self.manager = [[LineManager alloc] initWithLine:line percent:self.percent];
    [self setNeedsDisplay];
}

- (void)setShowGuideLines:(BOOL)showGuideLines
{
    _showGuideLines = showGuideLines;
    [self setNeedsDisplay];
}

- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // variables
    CGFloat guideLineWidth = 2.0;
    CGFloat lineWidth = 5.0;
    CGFloat speed = 0.01;
    
    // get/save current context
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // setup context
    CGContextSetLineCap(context, kCGLineCapRound);
    
    // draw guide lines
    if (self.showGuideLines)
    {
        // set guide line width
        CGContextSetLineWidth(context, guideLineWidth);
        
        // connect the lines
        NSArray *lines = self.line.associatedLines;
        for (NSInteger i = 0; i < lines.count; i++)
        {
            Line *line = lines[i];
            
            CGContextMoveToPoint(context, line.startPoint.x + guideLineWidth / 2, line.startPoint.y + guideLineWidth / 2);
            CGContextAddLineToPoint(context, line.endPoint.x + guideLineWidth / 2, line.endPoint.y + guideLineWidth / 2);
        }
        
        // stroke the path
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextStrokePath(context);
    }
    
    // set line width
    CGContextSetLineWidth(context, lineWidth);
    
    // move to the first point
    self.manager.percent = 0;
    CGContextMoveToPoint(context, self.manager.finalPoint.x + lineWidth / 2, self.manager.finalPoint.y + lineWidth / 2);
    
    // add most of the points
    for (CGFloat i = speed; i < self.percent; i += speed)
    {
        self.manager.percent = i;
        CGContextAddLineToPoint(context, self.manager.finalPoint.x + lineWidth / 2, self.manager.finalPoint.y + lineWidth / 2);
    }
    
    // add the last point
    self.manager.percent = self.percent;
    CGContextAddLineToPoint(context, self.manager.finalPoint.x + lineWidth / 2, self.manager.finalPoint.y + lineWidth / 2);
    
    // stroke the path
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextStrokePath(context);
    
    // restore context state
    CGContextRestoreGState(context);
}
@end
