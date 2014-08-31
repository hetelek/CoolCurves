//
//  DrawingView.h
//  CoolCurves
//
//  Created by Stevie Hetelekides on 8/29/14.
//  Copyright (c) 2014 Expetelek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineManager.h"

@interface LineCanvas : UIView

@property (nonatomic) Line *line;
@property (nonatomic, assign) CGFloat percent;
@property (nonatomic, assign) BOOL showGuideLines;

@end
