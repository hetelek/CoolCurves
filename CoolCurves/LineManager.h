//
//  LineManager.h
//  CoolCurves
//
//  Created by Stevie Hetelekides on 8/29/14.
//  Copyright (c) 2014 Expetelek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Line.h"

@interface LineManager : NSObject

@property Line *line;
@property (nonatomic, assign) CGFloat percent;
@property (readonly, assign) CGPoint finalPoint;

- (instancetype)initWithLine:(Line *)line percent:(CGFloat)percent;

@end
