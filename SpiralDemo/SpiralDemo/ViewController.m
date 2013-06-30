//
//  ViewController.m
//  SpiralDemo
//
//  Created by Zev Eisenberg on 6/30/13.
//  Copyright (c) 2013 Zev Eisenberg. All rights reserved.
//

#import "ViewController.h"
#import "ZESpiral.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

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
    
    self.startRadiusLabel.text = [NSString stringWithFormat:@"%f pt", self.startRadiusSlider.value];
    self.spacePerLoopLabel.text = [NSString stringWithFormat:@"%f", self.spacePerLoopSlider.value];
    self.startThetaLabel.text = [NSString stringWithFormat:@"%f radians", self.startThetaSlider.value];
    self.endThetaLabel.text = [NSString stringWithFormat:@"%f radians", self.endThetaSlider.value];
    self.thetaStepLabel.text = [NSString stringWithFormat:@"%f radians", self.thetaStepSlider.value];
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

@end
