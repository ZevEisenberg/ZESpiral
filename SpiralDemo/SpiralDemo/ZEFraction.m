//
//  ZEFraction.m
//  SpiralDemo
//
//  Created by Zev Eisenberg on 6/30/13.
//  Copyright (c) 2013 Zev Eisenberg. All rights reserved.
//

#import "ZEFraction.h"

@interface ZEFraction ()

@property (nonatomic) NSInteger numerator;
@property (nonatomic) NSInteger denominator;
@property (nonatomic) CGFloat realValue;

@end

@implementation ZEFraction

+ (id)fractionWithNumerator:(NSInteger)numerator denominator:(NSInteger)denominator
{
    ZEFraction *fraction = [[[self class] alloc] init];
    fraction.numerator = numerator;
    fraction.denominator = denominator;
    fraction.realValue = (CGFloat)numerator / (CGFloat)denominator;
    
    return fraction;
}

- (BOOL)isEqual:(id)object
{
    BOOL equal = NO;
    if ([object isKindOfClass:[self class]])
    {
        if ([(ZEFraction *)object numerator] == self.numerator &&
            [(ZEFraction *)object numerator] == self.denominator)
        {
            equal = YES;
        }
    }
    return equal;
}


- (NSString *)stringValue
{
    return [NSString stringWithFormat:@"%d/%d", self.numerator, self.denominator];
}

- (NSString *)stringValueIgnoringUnitDenominator:(BOOL)ignoreUnitDenominator
{
    if (self.denominator == 1 && ignoreUnitDenominator)
    {
        return [NSString stringWithFormat:@"%d", self.numerator];
    }
    else
    {
        return self.stringValue;
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %@ \u2248 %f>", [self class], self.stringValue, self.realValue];
}

@end
