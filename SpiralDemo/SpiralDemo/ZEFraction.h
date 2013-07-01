//
//  ZEFraction.h
//  SpiralDemo
//
//  Created by Zev Eisenberg on 6/30/13.
//  Copyright (c) 2013 Zev Eisenberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZEFraction : NSObject

@property (readonly) NSInteger numerator;
@property (readonly) NSInteger denominator;
@property (readonly) CGFloat realValue;

+ (id)fractionWithNumerator:(NSInteger)numerator denominator:(NSInteger)denominator;

- (NSString *)stringValue;
- (NSString *)stringValueIgnoringUnitDenominator:(BOOL)ignoreUnitDenominator;

@end
