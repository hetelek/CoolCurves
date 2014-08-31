//
//  ViewController.m
//  CoolCurves
//
//  Created by Stevie Hetelekides on 8/29/14.
//  Copyright (c) 2014 Expetelek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet LineCanvas *lineCanvas;
@property (weak, nonatomic) IBOutlet UISlider *percentSlider;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

@end

@implementation ViewController
- (IBAction)percentValueChanged:(UISlider *)sender
{
    self.lineCanvas.percent = sender.value;
    self.percentLabel.text = [NSString stringWithFormat:@"%.2f", sender.value];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.lineCanvas.percent = self.percentSlider.value;
    self.lineCanvas.showGuideLines = YES;
    self.view.backgroundColor = self.lineCanvas.backgroundColor;
    
    [self scrambleLines];
}

- (IBAction)scrambleLines
{
    self.lineCanvas.line = [self randomLineTree:(arc4random_uniform(8) + 2)];
}

- (Line *)randomLineTree:(NSInteger)count
{
    // a tree needs at least 2 anchor points
    if (count < 2)
        return nil;
    
    // create the array and populate it
    NSMutableArray *baseLines = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSInteger i = 0; i < count; i++)
    {
        Line *baseLine = [[Line alloc] init];
        
        // if this is the first line, it can start anywhere
        if (i == 0)
            baseLine.startPoint = [self randomPointInView:self.lineCanvas];
        else
        {
            // otherwise, it must start where the previous line started
            Line *previousBaseLine = (Line *)baseLines[i - 1];
            baseLine.startPoint = previousBaseLine.endPoint;
        }
        
        // it can end anywhere
        baseLine.endPoint = [self randomPointInView:self.lineCanvas];
        
        [baseLines addObject:baseLine];
    }
    
    // bridge them
    return [self bridgeLines:baseLines];
}

- (Line *)bridgeLines:(NSArray *)lines
{
    // create the array
    NSInteger bridgeCount = lines.count - 1;
    NSMutableArray *bridgeLines = [[NSMutableArray alloc] initWithCapacity:bridgeCount];
    
    // populate it with the bridge lines
    for (NSInteger i = 0; i < bridgeCount; i++)
    {
        // the parents of the bridge line are the lines from the passed array
        Line *bridgeLine = [[Line alloc] init];
        bridgeLine.parent1 = lines[i];
        bridgeLine.parent2 = lines[i + 1];
        
        [bridgeLines addObject:bridgeLine];
    }
    
    // if there's only 1 bridge, we are done
    if (bridgeCount == 1)
        return bridgeLines[0];
    else
        return [self bridgeLines:bridgeLines];
}

- (CGPoint)randomPointInView:(UIView *)view
{
    CGFloat x = (CGFloat)(arc4random_uniform((u_int32_t)self.view.bounds.size.width));
    CGFloat y = (CGFloat)(arc4random_uniform((u_int32_t)self.view.bounds.size.height));
    
    return CGPointMake(x, y);
}
@end
