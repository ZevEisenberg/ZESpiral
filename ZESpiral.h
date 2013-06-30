//
//  ZESpiral.h
//  SpiralDemo
//
//  Created by Zev Eisenberg on 6/30/13.
//  Copyright (c) 2013 Zev Eisenberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZESpiral : NSObject

+ (UIBezierPath *)spiralAtPoint:(CGPoint)center
                    startRadius:(CGFloat)startRadius
                   spacePerLoop:(CGFloat)spacePerLoop
                     startTheta:(CGFloat)startTheta
                       endTheta:(CGFloat)endTheta
                      thetaStep:(CGFloat)thetaStep;

@end
