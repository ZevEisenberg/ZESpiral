//
//  ViewController.m
//  SpiralDemo
//
//  Created by Zev Eisenberg on 6/30/13.
//  Copyright (c) 2013 Zev Eisenberg. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ZESpiral.h"
#import "ZEFraction.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *fractionsArray;

@property (weak, nonatomic) IBOutlet UISlider *startRadiusSlider;
@property (weak, nonatomic) IBOutlet UISlider *spacePerLoopSlider;
@property (weak, nonatomic) IBOutlet UISlider *startThetaSlider;
@property (weak, nonatomic) IBOutlet UISlider *endThetaSlider;
@property (weak, nonatomic) IBOutlet UISlider *thetaStepSlider;

@property (weak, nonatomic) IBOutlet UILabel *startRadiusLabel;
@property (weak, nonatomic) IBOutlet UILabel *spacePerLoopLabel;
@property (weak, nonatomic) IBOutlet UILabel *startThetaLabel;
@property (weak, nonatomic) IBOutlet UILabel *endThetaLabel;
@property (weak, nonatomic) IBOutlet UILabel *thetaStepLabel;

@property (strong, nonatomic) UIView *spiralView;
@property (strong, nonatomic) CAShapeLayer *spiralLayer;

- (IBAction)sliderChanged:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self populateFractionArrayWithMaximumDenominator:16];
    
    self.spiralView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.spiralView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:self.spiralView atIndex:0];
    
	self.spiralLayer = [CAShapeLayer layer];
    self.spiralLayer.position = self.spiralView.center;
    self.spiralLayer.bounds = self.spiralView.bounds;
    
    self.spiralLayer.lineWidth = 4;
    self.spiralLayer.strokeColor = [[UIColor redColor] colorWithAlphaComponent:.4].CGColor;
    self.spiralLayer.fillColor = [UIColor clearColor].CGColor;
    self.spiralLayer.lineCap = kCALineCapRound;
    [self.spiralView.layer addSublayer:self.spiralLayer];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateSpiral];
}

- (void)viewDidUnload
{
    [self setStartRadiusSlider:nil];
    [self setSpacePerLoopSlider:nil];
    [self setStartThetaSlider:nil];
    [self setEndThetaSlider:nil];
    [self setThetaStepSlider:nil];
    [super viewDidUnload];
}

- (void)updateSpiral
{
    self.spiralLayer.path = [ZESpiral spiralAtPoint:self.spiralView.center
                                        startRadius:self.startRadiusSlider.value
                                       spacePerLoop:self.spacePerLoopSlider.value
                                         startTheta:self.startThetaSlider.value
                                           endTheta:self.endThetaSlider.value
                                          thetaStep:self.thetaStepSlider.value].CGPath;
    
    ZEFraction *startThetaFraction = [self closestPiFractionToReal:self.startThetaSlider.value];
    ZEFraction *endThetaFraction = [self closestPiFractionToReal:self.endThetaSlider.value];
    ZEFraction *thetaStepFraction = [self closestPiFractionToReal:self.thetaStepSlider.value];
    
    NSString *startThetaString = startThetaFraction.numerator ? [startThetaFraction stringValueIgnoringUnitDenominator:YES] : @"0";
    NSString *endThetaString = endThetaFraction.numerator ? [endThetaFraction stringValueIgnoringUnitDenominator:YES] : @"0";
    NSString *thetaStepString = thetaStepFraction.numerator ? [thetaStepFraction stringValueIgnoringUnitDenominator:YES] : @"0";
    
    self.startRadiusLabel.text = [NSString stringWithFormat:@"%f pt", self.startRadiusSlider.value];
    self.spacePerLoopLabel.text = [NSString stringWithFormat:@"%f", self.spacePerLoopSlider.value];
    self.startThetaLabel.text = [NSString stringWithFormat:@"%f ≈ %@ π radians", self.startThetaSlider.value, startThetaString];
    self.endThetaLabel.text = [NSString stringWithFormat:@"%f ≈ %@ π radians", self.endThetaSlider.value, endThetaString];
    self.thetaStepLabel.text = [NSString stringWithFormat:@"%f ≈ %@ π radians", self.thetaStepSlider.value, thetaStepString];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self updateSpiral];
}

- (IBAction)sliderChanged:(id)sender
{
    [self updateSpiral];
}

#pragma mark - fraction calculations

//--------------------------------------------------
// Use an ascending Farey Series.
// Code adapted from http://en.wikipedia.org/wiki/Farey_sequence#Next_term
//--------------------------------------------------
- (void)populateFractionArrayWithMaximumDenominator:(NSUInteger)maximumDenominator
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger a = 0;
    NSInteger b = 1;
    NSInteger c = 1;
    NSInteger d = maximumDenominator;
    
    //--------------------------------------------------
    // First term is always 0/1.
    //--------------------------------------------------
    [array addObject:[ZEFraction fractionWithNumerator:a denominator:b]];
    
    while (c <= maximumDenominator)
    {
        NSInteger k = (maximumDenominator + b) / d;
        
        NSInteger oldA = a;
        NSInteger oldB = b;
        NSInteger oldC = c;
        NSInteger oldD = d;
        
        a = oldC;
        b = oldD;
        c = k * oldC - oldA;
        d = k * oldD - oldB;
        [array addObject:[ZEFraction fractionWithNumerator:a denominator:b]];
    }
    
    self.fractionsArray = [NSArray arrayWithArray:array];
}

- (ZEFraction *)closestPiFractionToReal:(CGFloat)real
{
    ZEFraction *returnFraction;
    
    CGFloat remainder = fmodf(real, M_PI);
    CGFloat remainderInRadians = remainder / M_PI;
    
    __block NSInteger closestIndex = -1;
    __block CGFloat minDifference = MAXFLOAT;
    
    [self.fractionsArray enumerateObjectsUsingBlock:^(ZEFraction *fraction, NSUInteger idx, BOOL *stop) {
        CGFloat absDifference = fabsf(remainderInRadians - fraction.realValue);
        if (absDifference < minDifference)
        {
            minDifference = absDifference;
            closestIndex = idx;
            if (minDifference == 0)
            {
                *stop = YES;
            }
        }
    }];
    
    if (closestIndex != -1)
    {
        CGFloat wholePart = floorf(real / M_PI); // the whole part of the mixed number we are looking for
        
        ZEFraction *closestFraction = self.fractionsArray[closestIndex];
        NSInteger denominator = closestFraction.denominator;
        NSInteger numerator = wholePart * denominator + closestFraction.numerator;
        returnFraction = [ZEFraction fractionWithNumerator:numerator denominator:denominator];
    }
    else
    {
        [NSException raise:NSInternalInconsistencyException format:@"There should always be a closest index."];
    }
    
    return returnFraction;
}

@end
