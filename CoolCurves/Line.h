//
//  Line.h
//  CoolCurves
//
//  Created by Stevie Hetelekides on 8/29/14.
//  Copyright (c) 2014 Expetelek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Line : NSObject

@property Line *parent1;
@property Line *parent2;

@property (assign) CGPoint startPoint;
@property (assign) CGPoint endPoint;

@property (nonatomic, readonly) NSArray *associatedLines;

- (CGPoint)pointAtPercent:(CGFloat)percent;
- (void)updatePoints:(CGFloat)percent;

@end
