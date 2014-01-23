//
//  ZESpiral.h
//  SpiralDemo
//
//  Created by Zev Eisenberg on 6/30/13.
//  Copyright (c) 2013 Zev Eisenberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZESpiral : NSObject

/**
 *  Creates and returns a new UIBezierPath object initialized with an Archimedean spiral.
 *
 *  @param center       The center point of the spiral.
 *  @param startRadius  The spiral starts this far from the center.
 *  @param spacePerLoop The amount that the spiral grows in one revolution.
 *  @param startTheta   The angle, in radians, at which to start the inside of the spiral.
 *  @param endTheta     The angle, in radians, at which to end the spiral. Every 2π radians equals 1 full turn.
 *  @param thetaStep    The distance, in radians, between each control point on the retulting Bézier path. A smaller theta step results in a smoother curve, but with more points, which could impact performance.
 *
 *  @return A new path object with the specified spiral.
 */
+ (UIBezierPath *)spiralAtPoint:(CGPoint)center
                    startRadius:(CGFloat)startRadius
                   spacePerLoop:(CGFloat)spacePerLoop
                     startTheta:(CGFloat)startTheta
                       endTheta:(CGFloat)endTheta
                      thetaStep:(CGFloat)thetaStep;

@end
