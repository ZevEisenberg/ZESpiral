//
//  ZESpiral.m
//  SpiralDemo
//
//  Created by Zev Eisenberg on 6/30/13.
//  Copyright (c) 2013 Zev Eisenberg. All rights reserved.
//

#import "ZESpiral.h"

//--------------------------------------------------
// Takes two lines in slope-intercept form.
// Returns YES if they intersect, otherwise no.
// Returns by reference the point where the two lines intersect.
//--------------------------------------------------
BOOL ZELineIntersection(double m1, double b1,
                        double m2, double b2,
                        double *X, double *Y)
{
    if (m1 == m2)
    {
        // lines are parallel
        return NO;
    }
    *X = (b2 - b1) / (m1 - m2);
    
    *Y = m1 * *X + b1;
    
    return YES;
}

@implementation ZESpiral

+ (UIBezierPath *)spiralAtPoint:(CGPoint)center
                    startRadius:(CGFloat)startRadius
                   spacePerLoop:(CGFloat)spacePerLoop
                     startTheta:(CGFloat)startTheta
                       endTheta:(CGFloat)endTheta
                      thetaStep:(CGFloat)thetaStep
{    
    //--------------------------------------------------
    // Rename spiral parameters for the formula r = a + bθ
    //--------------------------------------------------
    CGFloat a = startRadius;  // start distance from center
    CGFloat b = spacePerLoop; // space between each loop
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float oldTheta = startTheta;
    float newTheta = startTheta;
    
    float oldR = a + b * oldTheta;
    float newR = a + b * newTheta;
    
    CGPoint oldPoint = CGPointZero;
    CGPoint newPoint = CGPointZero;
    
    float oldSlope = MAXFLOAT;
    float newSlope = MAXFLOAT;
    
    //--------------------------------------------------
    // Move to the initial point before entering the loop, because
    // we want to do it only once.
    //--------------------------------------------------
    newPoint.x = center.x + oldR * cosf(oldTheta);
    newPoint.y = center.y + oldR * sinf(oldTheta);
    
    [path moveToPoint:newPoint];
    
    BOOL firstSlope = YES;
    while (oldTheta < endTheta - thetaStep)
    {
        oldTheta = newTheta;
        newTheta += thetaStep;
        
        oldR = newR;
        newR = a + b * newTheta;
        
        oldPoint.x = newPoint.x;
        oldPoint.y = newPoint.y;
        newPoint.x = center.x + newR * cosf(newTheta);
        newPoint.y = center.y + newR * sinf(newTheta);
        
        //--------------------------------------------------
        // Slope calculation with the formula:
        // (b * sinΘ + (a + bΘ) * cosΘ) / (b * cosΘ - (a + bΘ) * sinΘ)
        //--------------------------------------------------
        float aPlusBTheta = a + b * newTheta;
        if (firstSlope)
        {
            oldSlope = ((b * sinf(oldTheta) + aPlusBTheta * cosf(oldTheta)) /
                        (b * cosf(oldTheta) - aPlusBTheta * sinf(oldTheta)));
            firstSlope = NO;
        }
        else
        {
            oldSlope = newSlope;
        }
        newSlope = (b * sinf(newTheta) + aPlusBTheta * cosf(newTheta)) / (b * cosf(newTheta) - aPlusBTheta * sinf(newTheta));
        
        CGPoint controlPoint = CGPointZero;
        
        double oldIntercept = -(oldSlope * oldR * cosf(oldTheta) - oldR * sinf(oldTheta));
        double newIntercept = -(newSlope * newR* cosf(newTheta) - newR * sinf(newTheta));
        
        double outX, outY;
        
        BOOL result = ZELineIntersection(oldSlope, oldIntercept, newSlope, newIntercept, &outX, &outY);
        
        if (result)
        {
            controlPoint.x = outX;
            controlPoint.y = outY;
        }
        else
        {
            [NSException raise:NSInternalInconsistencyException format:@"These lines should never be parallel."];
        }
        
        //--------------------------------------------------
        // Offset the control point by the center offset.
        //--------------------------------------------------
        controlPoint.x += center.x;
        controlPoint.y += center.y;
        
        [path addQuadCurveToPoint:newPoint controlPoint:controlPoint];
    }
    
    return path;
}

@end
